//
//  AsyncTaskButton.m
//  GT3Example
//
//  Created by NikoXu on 2019/12/10.
//  Copyright © 2019 Xniko. All rights reserved.
//

#import "AsyncTaskButton.h"
#import "TipsView.h"

@interface AsyncTaskButton () <GT3CaptchaManagerDelegate, GT3CaptchaManagerViewDelegate>

@property (nonatomic, strong) GT3CaptchaManager *manager;
@property (nonatomic, strong) DemoAyncTask *asyncTask;

@end

@implementation AsyncTaskButton

- (GT3CaptchaManager *)manager {
    if (!_manager) {
        _manager = [[GT3CaptchaManager alloc] initWithAPI1:nil API2:nil timeout:5.0];
        _manager.delegate = self;
        _manager.viewDelegate = self;
        _manager.maskColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        [_manager useGTViewWithCornerRadius:14.0];
//        [_manager useLanguage:lang];
//        [_manager enableDebugMode:YES];
//        [_manager useVisualViewWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    }
    return _manager;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self _init];
        
        [self addTarget:self action:@selector(startCaptcha) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self _init];
        
        [self addTarget:self action:@selector(startCaptcha) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)_init {
    DemoAyncTask *asyncTask = [[DemoAyncTask alloc] init];
    asyncTask.delegate = self;
    
    /// asyncTask 被管理器内部以弱引用方式持有，
    /// 所以需要开发者自己在调用类中保持，以保证管理器在后续流程中能正常访问到该对象
    self.asyncTask = asyncTask;
    
    [self.manager registerCaptchaWithCustomAsyncTask:asyncTask completion:nil];
}

- (void)startCaptcha {
    if (_delegate && [_delegate respondsToSelector:@selector(captchaButtonShouldBeginTapAction:)]) {
        if (![_delegate captchaButtonShouldBeginTapAction:self]) {
            return;
        }
    }
    
    [self.manager startGTCaptchaWithAnimated:YES];
}

- (void)stopCaptcha {
    [self.manager stopGTCaptcha];
}

#pragma DemoAyncTaskDelegate

- (void)asyncTaskDidFinish:(BOOL)status error:(GT3Error *)error {
    if (_delegate && [_delegate respondsToSelector:@selector(captchaDidFinish:error:)]) {
        [_delegate captchaDidFinish:status error:error];
    }
}

#pragma GT3CaptchManagerViewDelegate

- (void)gtCaptchaWillShowGTView:(GT3CaptchaManager *)manager {
    if (_delegate && [_delegate respondsToSelector:@selector(captchaWillDisplay)]) {
        [_delegate captchaWillDisplay];
    }
}

#pragma GT3CaptchaManagerDelegate

- (void)gtCaptcha:(GT3CaptchaManager *)manager errorHandler:(GT3Error *)error {
    if (_delegate && [_delegate respondsToSelector:@selector(captchaDidFinish:error:)]) {
        [_delegate captchaDidFinish:NO error:error];
    }
}

- (void)gtCaptcha:(GT3CaptchaManager *)manager didReceiveSecondaryCaptchaData:(NSData *)data response:(NSURLResponse *)response error:(GT3Error *)error decisionHandler:(void (^)(GT3SecondaryCaptchaPolicy))decisionHandler {
    
}

@end
