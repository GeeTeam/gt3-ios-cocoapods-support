//
//  AsyncTaskButton.h
//  GT3Example
//
//  Created by NikoXu on 2019/12/10.
//  Copyright © 2019 Xniko. All rights reserved.
//

#import "DemoAyncTask.h"

@import GT3Captcha;

NS_ASSUME_NONNULL_BEGIN

@protocol AsyncTaskCaptchaButtonDelegate;

/**
 demo场景: 仅自定按钮与验证事件绑定
 */
@interface AsyncTaskButton : UIButton <DemoAyncTaskDelegate>

@property (nonatomic, weak) id<AsyncTaskCaptchaButtonDelegate> delegate;

- (void)startCaptcha;
- (void)stopCaptcha;

@end

@protocol AsyncTaskCaptchaButtonDelegate <NSObject>

@optional
- (void)captchaWillDisplay;

- (BOOL)captchaButtonShouldBeginTapAction:(AsyncTaskButton *)button;
- (void)captchaDidFinish:(BOOL)status error:(GT3Error *)error;

@end

NS_ASSUME_NONNULL_END
