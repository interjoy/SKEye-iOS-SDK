# SKEye-iOS-SDK
SKEye-iOS-SDK for Object Recognition Service 
###  更新日志
v1.0.0
- 发布常见物体识别、水果识别功能
###  目录介绍
- libs:SKEyeSDK.framework。
- SKEyeSDKDemo:Recognition文件夹下recognitionVController.m文件包含识别接口调用。
- 说明文档(SKEye-iOS-SDK说明文档V1.0.0.pdf)
###  使用步骤
- 下载zip。
- 在Xcode里新建工程，将SKEyeSDK.framework文件拷贝到工程的目录下，然后从SDK的保存目录拖拽到工程导航试图中的Frameworks虚拟目录下。调用时导入头文件：
```
#import “SKEyeSDK/eyeTool.h”
```
- SDK接口请求使用https协议，需要在项目info.plist中添加如下字段

![image](http://s13.sinaimg.cn/mw690/006jksDEzy7axSnpYRK1c&690)
- 更多使用介绍请参考[SKEyeSDKDemo](https://github.com/interjoy/SKEye-iOS-SDK/tree/master/SKEyeSDKDemo)和 [《SKEye-iOS-SDK说明文档V1.0.0》](https://github.com/interjoy/SKEye-iOS-SDK/blob/master/SKEye-iOS-SDK说明文档V1.0.0.pdf)。
###  调用示例
```
+ (void)SKEyeSDK_Image:(UIImage *)image service_name:
(SK_SERVICE_NAME*)server_name callBack:(void(^)
(id responseObject))callBack;
```
###  SDK问题反馈
- SKEye开放平台QQ群：617518775
