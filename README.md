# GT3Captcha
极验行为验证SDK库

CocoaPods 引入方式，如依赖制定版本如 0.12.6 版本可以参考下面的脚本 

`pod 'GT3Captcha-iOS', '~> 0.12.6'`

版本|更新内容|更新日期
-----|-----|-----
**0.13.2**  |1. 新增圆角设置方法 </br> 2. 新增自定义注册和校验过程的方法 `registerCaptchaWithCustomAsyncTask:completion:` </br> 3. 抛弃 `configureGTest:challenge:success:withAPI2:` 方法| 2019-12-17
**0.12.7**  |1. 修复导致无法调用验证的问题 </br> 2. 修复潜在引发 crash 的问题 | 2019-11-11
**0.12.6**  |1. `startGTCaptchaWithAnimated` 和 `closeGTViewIfIsOpen` 调整到主线执行 </br> 2. 修复已知的问题 | 2019-10-14


详情见 [极验官网](http://www.geetest.com) 相关开发文档
