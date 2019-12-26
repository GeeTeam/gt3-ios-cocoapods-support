# GT3Captcha Project

## 概述

极验验证 3.0 iOS SDK 提供给集成 iOS 原生客户端开发的开发者使用, SDK 不依赖任何第三方库。

请详细阅读 [官网文档](https://docs.geetest.com/install/overview/start/)

## 环境需求

条目	|			|
------	|---------|
开发目标|兼容 iOS7, 推荐 iOS8+|
开发环境|Xcode 11.0|
系统依赖|`Webkit.framework`|
SDK 三方依赖|无		|
资源依赖 |依赖 `GT3Captcha.Bundle` |

## 获取 SDK

### 使用CocoaPods获取

在工程的 `Podfile` 文件中添加下面配置

`pod 'GT3Captcha-iOS'`

### 手动下载获取

使用从 github 下载`.zip`文件获取最新的 SDK.

[Github: gt3-ios-sdk](https://docs.geetest.com/install/deploy/client/ios#获取SDK)

## 使用

### 引入 `GT3Captcha.framework`

使用 `Linked Frameworks and Libraries` 方式引入  `GT3Captcha.framework`. `GT3Captcha.framework` 是 `Static Library`, 支持 iOS7+.

### Demo 提供的示例场景
使用参见根部目录下的 `GT3Example` Demo 工程, Demo 包含以下场景:

1. 在登录使用 SDK 默认封装接口 `LoginViewController`
2. 在注册使用 SDK 默认封装接口`RegisterViewController`
3. 在自定义按钮下使用 SDK 默认封装接口 `CustomButton`
4. <del>在自定义按钮下使用自定义接口 `AsyncButton`</del>
5. 使用自定义注册和校验逻辑 `AsyncTaskButton`

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
极验验证 3.0 产品简介 [产品简介](https://docs.geetest.com/install/overview/guide)

SDK 安装教程见 [官方文档](https://docs.geetest.com/install/deploy/client/ios)

SDK 接口文档见 [接口文档](https://docs.geetest.com/install/apirefer/api/ios)

错误码见 [错误码清单](https://docs.geetest.com/install/apirefer/errorcode/ios) 

## 接口

集成前需要先了解极验验证 3.0 的[产品结构](https://docs.geetest.com/install/overview/flowchart), 并且必须要先在您的后端搭建相应的**服务端 SDK**，并配置从 [极验后台](https://auth.geetest.com/login) 获取的 验证ID 和 验证Key 用来配置您集成了极验服务端 SDK 的后台.

其中 iOS SDK 主要提供以下接口:

1. 配置验证初始化
2. 启动验证
3. 验证生命周期的代理方法
	* 错误处理
	* 结果处理
	* 流程控制 
