# GT3Captcha Project

## 概述

极验验证 3.0 iOS SDK 提供给集成 iOS 原生客户端开发的开发者使用, SDK 不依赖任何第三方库.

SDK 提供 **Bitcode 版本** 和 **非 Bitcode 版本** 两个版本

## 环境需求

条目	|			|
------	|---------|
开发目标|兼容 iOS7, 推荐 iOS8+|
开发环境|Xcode 8.0|
系统依赖|`Webkit.framework`, `JavaScriptCore.framework`|
SDK 三方依赖|无		|
资源依赖 |依赖 `GT3Captcha.Bundle` |

## 获取 SDK

### 手动下载获取
使用从 github 下载`.zip`文件获取最新的 SDK.

[Github: gt3-ios-sdk](https://docs.geetest.com/downloads/gt3-ios-latest.zip)

## 使用

### 引入 `GT3Captcha.framework`

使用 `Linked Frameworks and Libraries` 方式引入  `GT3Captcha.framework`. `GT3Captcha.framework` 是 `Static Library`, 支持 iOS7+.

### Demo 提供的示例场景
使用参见根部目录下的 `GT3Example` Demo 工程, Demo 包含以下场景:

1. 在登录使用 SDK 默认封装接口 `LoginViewController`
2. 在注册使用 SDK 默认封装接口`RegisterViewController`
3. 在自定义按钮下使用 SDK 默认封装接口 `CustomButton`
4. 在自定义按钮下使用自定义接口 `AsyncButton`

### 语言环境配置
Demo 以 iOS8 作为示例, 语言默认支持中文简体、中文繁体、英文，但需要在 `.plist` 里添加如下属性(已存在的不用再次添加):

```xml
<key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>zh_CN</string>
		<string>zh_TW</string>
	</array>
```

### SDK 及产品详情
极验验证 3.0 产品简介 [产品简介](https://docs.geetest.com/install/overview/start/)

SDK 安装教程见 [官方文档](https://docs.geetest.com/install/deploy/client/ios)

SDK 接口文档见 [接口文档](https://docs.geetest.com/install/apirefer/api/ios)

错误码见 [错误码清单](https://docs.geetest.com/install/apirefer/errorcode/ios) 

## 接口

集成前需要先了解极验验证 3.0 的[产品结构](http://docs.geetest.com/install/overview/#产品结构), 并且必须要先在您的后端搭建相应的**服务端 SDK**，并配置从 [极验后台](https://account.geetest.com/login) 获取的 `<gt_captcha_id>` 和 `<geetest_key>`用来配置您集成了极验服务端 SDK 的后台.

其中 iOS SDK 主要提供以下接口:

1. 配置验证初始化
2. 启动验证
3. 验证生命周期的代理方法
	* 错误处理
	* 结果处理
	* 流程控制 

## 更新日志

* **0.11.4:**  httpsdns支持https ip 直连;
* **0.11.2:**  新增至11种语言支持; 语言接口支持指定语言及跟随系统; 使用自定义的window作为视图容器; 修复一处可能由CGColorRef导致的crash;
* **0.11.0:**  大量问题修复; 新增网络鉴权代理; 适配新接口; 增强弱网可用性; 新增网络异常报告; 
* **0.10.2:**  新增日语支持; 优化内部流程;
* **0.10.1:**  优化网络模块; 优化内部状态控制; 功能增强; 新增印尼语支持; 其它问题修复;
* **0.9.0:**  添加 `GT3Captcha.Bundle`, 为 `Static Library` 单独管理图片、文件等资源; 
* **0.8.10:**  修复潜在 bug; 增强统计接口;
* **0.8.8:**  修复潜在的 crash 问题; 修复内存泄漏; 增加 debug 代理;
* **0.8.6:**  紧急修复 `openURL:` 在 iOS11 上导致的 crash 问题;
* **0.8.5:**  优化高度获取方案; 其他问题修复;
* **0.8.1:**  修复 iOS8+ 网络 bug; 细节优化;
* **0.7.10:**  错误统一; UI 逻辑调整;
* **0.7.6:**  改善数据; 其他问题修复;
* **0.7.2:**  改善数据交互; 增加 forbidden 事件;
* **0.6.3:**  修复 onepass 下没有图形提示的问题; 修复因状态不一致导致的 server 返回 'runtime error';
* **0.6.2:**  解决 0.6.1 版在部分情况下, 执行动画导致 CPU 高消费; 解决已发现在数据层面导致的服务端返回 'runtime error' 的问题;
* **0.6.1:**  针对按钮绑定集成验证优化；针对反馈提供更多新接口；改善初始化体验；提供更详实的演示 Demo;
* **0.5.7:**  修正 `NSBundle` 在非 embedded binaries 中的问题;
* **0.5.6:**  修改提示文案；`GTCaptchaManagerViewDelegate` 方法更新；验证成功后再次验证只需要点击一次;
* **0.5.5:**  对 `GT3CaptchaButton` 增加可选的代理方法;
* **0.5.4:**  完善验证管理器生命周期;
* **0.5.3:**  修复在未检测到传感器的情况下的表现行为；优化销毁逻辑;
* **0.5.2:**  修改多交互逻辑, 界面适配修正;
* **0.5.0:**  变更为静态库以支持 iOS7；支持静默验证；少量修复和改善;
