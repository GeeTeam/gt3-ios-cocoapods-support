//
//  DemoAyncTask.h
//  GT3Example
//
//  Created by NikoXu on 2019/12/10.
//  Copyright © 2019 Xniko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GT3Captcha/GT3AsyncTaskProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DemoAyncTaskDelegate <NSObject>

- (void)asyncTaskDidFinish:(BOOL)status error:(nullable GT3Error *)error;

@end

@interface DemoAyncTask : NSObject <GT3AsyncTaskProtocol>

@property (nonatomic, weak) id<DemoAyncTaskDelegate> delegate;

- (void)executeValidationTaskWithValidateParam:(GT3ValidationParam *)param completion:(void (^)(BOOL, GT3Error * _Nullable))completion;
- (void)executeRegisterTaskWithCompletion:(void (^)(GT3RegisterParameter * _Nullable, GT3Error * _Nullable))completion;

- (void)cancel;

@end

NS_ASSUME_NONNULL_END
