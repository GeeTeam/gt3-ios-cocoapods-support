//
//  AsyncTaskViewController.m
//  GT3Example
//
//  Created by NikoXu on 2019/12/10.
//  Copyright © 2019 Xniko. All rights reserved.
//

#import "AsyncTaskViewController.h"

#import "AsyncTaskButton.h"
#import "TextField.h"
#import "TipsView.h"

#import "NSAttributedString+AttributedString.h"

@interface AsyncTaskViewController () <AsyncTaskCaptchaButtonDelegate>

@property (nonatomic, strong) TextField *phoneNumberTextField;
@property (nonatomic, strong) TextField *smsCodeTextField;

@end

@implementation AsyncTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _init];
}

- (void)_init {
    [self setupTitle];
    [self setupPhoneNumberTextField];
    [self setupSMSCodeTextField];
    [self setupSMSButton];
    [self setupRegisterButton];
}

- (void)setupTitle {
    UILabel *label = [[UILabel alloc] init];
    
    NSAttributedString *attrString = [NSAttributedString generate:@"注册" fontSize:36.0 color:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0]];
    
    label.attributedText = attrString;
    [label sizeToFit];
    
    label.center = CGPointMake(self.view.center.x, self.view.center.y - 132);
    
    [self.view addSubview:label];
}

- (void)setupPhoneNumberTextField {
    self.phoneNumberTextField = [[TextField alloc] initWithFrame:CGRectMake(0, 0, 260, 40) placeholder:@"手机号" keyboardType:UIKeyboardTypeNumbersAndPunctuation lengthLimit:44];
    self.phoneNumberTextField.text = @"18620000000";
    self.phoneNumberTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.phoneNumberTextField.center = CGPointMake(self.view.center.x, self.view.center.y - 22);
    
    [self.view addSubview:self.phoneNumberTextField];
}

- (void)setupSMSCodeTextField {
    self.smsCodeTextField = [[TextField alloc] initWithFrame:CGRectMake(0, 0, 124, 40) placeholder:@"短信验证码" keyboardType:UIKeyboardTypeNumberPad lengthLimit:44];
    self.smsCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.smsCodeTextField.center = CGPointMake(self.view.center.x - 68, self.view.center.y + 22);
    
    [self.view addSubview:self.smsCodeTextField];
}

- (void)setupSMSButton {
    
    AsyncTaskButton *button = [[AsyncTaskButton alloc] initWithFrame:CGRectMake(0, 0, 124, 40)];
    button.delegate = self;
    button.backgroundColor = [UIColor colorWithRed:0.36 green:0.8 blue:0.44 alpha:1.0];
    [button setClipsToBounds:YES];
    
    NSAttributedString *attrString = [NSAttributedString generate:@"获取验证码" fontSize:16.0 color:[UIColor whiteColor]];
    
    button.layer.cornerRadius = 2.0;
    button.titleLabel.attributedText = attrString;
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.center = CGPointMake(self.view.center.x + 68, self.view.center.y + 22);
    
    [self.view addSubview:button];
    
}

- (void)setupRegisterButton {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 260, 40)];
    
    button.backgroundColor = [UIColor lightGrayColor];
    [button setClipsToBounds:YES];
    
    NSAttributedString *attrString = [NSAttributedString generate:@"登录" fontSize:16.0 color:[UIColor whiteColor]];
    
    button.layer.cornerRadius = 2.0;
    button.titleLabel.attributedText = attrString;
    [button setTitle:@"登录" forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor whiteColor];
    CGFloat bias = -56.0;
    button.center = CGPointMake(self.view.center.x, self.view.center.y + 130 + bias);
    
    [button addTarget:self action:@selector(userRegister) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)captcha {
    
}

- (void)userRegister {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}

#pragma mark - AsyncTaskCaptchaButtonDelegate

- (void)captchaWillDisplay {
    [TipsView removeAllTipsView];
}

- (BOOL)captchaButtonShouldBeginTapAction:(AsyncTaskButton *)button {
    [TipsView showTipOnKeyWindow:@"正在检测\n智能账号安全..."];
    return YES;
}

- (void)captchaDidFinish:(BOOL)status error:(GT3Error *)error {
    if (!error) {
        // 演示中全部默认为成功, 不对返回做判断
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.phoneNumberTextField.text isEqualToString:@"12345678900"]) {
                [TipsView showTipOnKeyWindow:@"DEMO: 已存在的手机号"];
            }
            else {
                self.smsCodeTextField.text = @"88888888";
                [TipsView showTipOnKeyWindow:@"DEMO: 获取短信验证码:88888888" fontSize:12];
            }
        });
    }
    else {
        //处理验证中返回的错误
        if (error.code == -999) {
            // 请求被意外中断,一般由用户进行取消操作导致
        }
        else if (error.code == -10) {
            // 预判断时被封禁, 不会再进行图形验证
        }
        else if (error.code == -20) {
            // 尝试过多
        }
        else {
            // 网络问题或解析失败, 更多错误码参考开发文档
        }
        [TipsView showTipOnKeyWindow:error.error_code fontSize:12.0];
    }
}

- (void)dealloc {
    NSLog(@"VC did release");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
