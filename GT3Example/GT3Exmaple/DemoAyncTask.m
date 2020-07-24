//
//  DemoAyncTask.m
//  GT3Example
//
//  Created by NikoXu on 2019/12/10.
//  Copyright © 2019 Xniko. All rights reserved.
//

#import "DemoAyncTask.h"

//网站主部署的用于验证注册的接口 (api_1)
#define api_1 @"http://www.geetest.com/demo/gt/register-slide"
//网站主部署的二次验证的接口 (api_2)
#define api_2 @"http://www.geetest.com/demo/gt/validate-slide"

@interface DemoAyncTask ()

@property (nonatomic, strong) NSURLSessionDataTask *registerDataTask;
@property (nonatomic, strong) NSURLSessionDataTask *validateDataTask;

@end

@implementation DemoAyncTask

- (void)executeValidationTaskWithValidateParam:(GT3ValidationParam *)param completion:(void (^)(BOOL, GT3Error * _Nullable))completion {
    /**
     *  TO-DO 处理result数据, 进行二次验证
     */
    __block NSMutableArray *postArray = [[NSMutableArray alloc] init];
    [param.result enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
        NSString *paramItem = [NSString stringWithFormat:@"%@=%@", key, obj];
        [postArray addObject:paramItem];
    }];
    
    NSString *postForm = [postArray componentsJoinedByString:@"&"];
    
    NSDictionary *headerFields = @{@"Content-Type":@"application/x-www-form-urlencoded;charset=UTF-8"};
    NSMutableURLRequest *secondaryRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:api_2] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15.0];
    secondaryRequest.HTTPMethod = @"POST";
    secondaryRequest.allHTTPHeaderFields = headerFields;
    secondaryRequest.HTTPBody = [postForm dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    self.validateDataTask = [session dataTaskWithRequest:secondaryRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (!error && httpResponse.statusCode == 200) {
            NSError *err;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
            if (!err) {
                NSString *status = [dict objectForKey:@"status"];
                if ([status isEqualToString:@"success"]) {
                    NSLog(@"通过业务流程");
                    
                    if (completion) {
                        completion(YES, nil);
                    }
                    
                    if (_delegate && [_delegate respondsToSelector:@selector(asyncTaskDidFinish:error:)]) {
                        [_delegate asyncTaskDidFinish:YES error:nil];
                    }
                }
                else {
                    if (completion) {
                        completion(NO, nil);
                    }
                    NSLog(@"无法通过业务流程");
                    
                    if (_delegate && [_delegate respondsToSelector:@selector(asyncTaskDidFinish:error:)]) {
                        [_delegate asyncTaskDidFinish:NO error:nil];
                    }
                }
            }
            else {
                GT3Error *anErr = [GT3Error errorWithDomainType:GT3ErrorTypeExtern originalError:err withGTDesciption:@"Error occur."];
                
                if (completion) {
                    completion(nil, anErr);
                }
                if (_delegate && [_delegate respondsToSelector:@selector(asyncTaskDidFinish:error:)]) {
                    [_delegate asyncTaskDidFinish:NO error:anErr];
                }
                NSLog(@"error:\n%@", err.localizedDescription);
            }
        }
        else {
            GT3Error *err = [GT3Error errorWithDomainType:GT3ErrorTypeExtern originalError:error withGTDesciption:@"Error occur."];
            
            if (completion) {
                completion(nil, err);
            }
            
            if (_delegate && [_delegate respondsToSelector:@selector(asyncTaskDidFinish:error:)]) {
                [_delegate asyncTaskDidFinish:NO error:err];
            }
            NSLog(@"error:\n%@", error.localizedDescription);
        }
    }];
    
    [self.validateDataTask resume];
}

- (void)executeRegisterTaskWithCompletion:(void (^)(GT3RegisterParameter * _Nullable, GT3Error * _Nullable))completion {
    
    /**
     *  TO-DO 从接口解析是否开启极验3.0, 并解析和配置验证参数
     *  不要重复调用, 在交互上需要处理用户的短时间内多次点击的问题
     */
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *newURL = [NSString stringWithFormat:@"%@?t=%.0f", api_1, [[[NSDate alloc] init]timeIntervalSince1970]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:newURL]];
    self.registerDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingOptions)0 error:&error];
            
            if (!error && dict) {
                NSString *geetest_id = [dict objectForKey:@"gt"];
                NSString *geetest_challenge = [dict objectForKey:@"challenge"];
                NSNumber *geetest_success = [dict objectForKey:@"success"];
                
                if (geetest_id && geetest_challenge && geetest_success) {
                    GT3RegisterParameter *param = [[GT3RegisterParameter alloc] init];
                    param.gt        = geetest_id;
                    param.challenge = geetest_challenge;
                    param.success   = geetest_success;
                    
                    if (completion) {
                        completion(param, nil);
                    }
                }
            }
        }
        else {
            GT3Error *err = [GT3Error errorWithDomainType:GT3ErrorTypeExtern originalError:error withGTDesciption:@"Error occur."];
            
            if (completion) {
                completion(nil, err);
            }
            NSLog(@"error:\n%@", error.localizedDescription);
        }
    }];
    
    [self.registerDataTask resume];
}

- (void)cancel {
    if (self.registerDataTask) {
        [self.registerDataTask cancel];
    }

    if (self.validateDataTask) {
        [self.validateDataTask cancel];
    }
}

@end
