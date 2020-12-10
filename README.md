# GT3Captcha
极验行为验证SDK库

CocoaPods 引入方式，如依赖制定版本如 0.12.6 版本可以参考下面的脚本 

`pod 'GT3Captcha-iOS', '~> 0.12.6'`

版本|更新内容|更新日期
-----|-----|-----
**0.14.3**  |1. ipv6 适配 <br> 2. 其他更新| 2020-12-10
**0.14.1**  |1. 安全性更新 <br> 2. 其他更新| 2020-11-18
**0.14.0**  |1. 优化日志接口 </br> 2. 优化其他已知问题| 2020-08-04
**0.13.9**  |1. 优化 keyWindow 处理逻辑 </br> 2. 优化其他已知问题| 2020-07-24
**0.13.8**  |1. 修复潜在的 UI 卡顿问题 </br> 2. 修复 `GT3CaptchaButton` 信息提示不正确的问题 </br> 3. 优化其他已知问题| 2020-07-01
**0.13.6**  |1. 处理可能导致无限重试的问题 </br> 2. 优化 failback 的细节 </br> 3. 新增 Swift 示例代码| 2020-05-06
**0.13.5**  |1. 参考国家互联网信息办公室、工信部等四部门联合印发《App违法违规收集使用个人信息认定方法》对 SDK 进行合规处理 | 2020-04-23
**0.13.4**  |1. 兼容 SceneDelegate </br> 2. 修复大图模式在 4/4s/5/5s/SE 等设备横屏时显示不全的问题 </br> 3. 新增给用户自定义前端参数的接口 `- (void)useGTViewWithParams:(NSDictionary *)params`|2020-03-17
**0.13.2**  |1. 新增圆角设置方法 </br> 2. 新增自定义注册和校验过程的方法 `registerCaptchaWithCustomAsyncTask:completion:` </br> 3. 抛弃 `configureGTest:challenge:success:withAPI2:` 方法| 2019-12-17
**0.12.7**  |1. 修复导致无法调用验证的问题 </br> 2. 修复潜在引发 crash 的问题 | 2019-11-11
**0.12.6**  |1. `startGTCaptchaWithAnimated` 和 `closeGTViewIfIsOpen` 调整到主线执行 </br> 2. 修复已知的问题 | 2019-10-14


详情见 [极验官网](http://www.geetest.com) 相关开发文档
