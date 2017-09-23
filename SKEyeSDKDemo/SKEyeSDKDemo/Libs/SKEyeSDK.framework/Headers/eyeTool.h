//
//  eyeTool.h
//  SKSmartEye_ObjectSDK
//
//  Created by cdong on 2017/3/27.
//  Copyright © 2017年 DC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double SKEyeSDKVersionNumber;
FOUNDATION_EXPORT const unsigned char SKEyeSDKVersionString[];

// --- 服务名:SK_SERVICE_NAME ---
typedef NSString SK_SERVICE_NAME;
extern NSString *SERVICE_NAME_OBJECT;    // 常见物品识别服务名
extern NSString *SERVICE_NAME_FRUITS;    // 水果识别服务名

@interface eyeTool : NSObject

/*
 * SDK初始化
 **/
+ (void)SKEyeSDK_InitWithApiKey:(NSString *)apiKey apiSecret:(NSString *)apiSecret;

/*
 * 上传图片数据
 * 可携带参数imageId
 * 回调方式
 **/
+ (void)SKEyeSDK_ImageId:(NSString *)imageId image:(UIImage *)image service_name:(SK_SERVICE_NAME*)serviceName callBack:(void(^)(id responseObject))callBack;

/*
 * 上传本地路径或者URL指向图片
 * 可携带参数imageId
 * 回调方式
 **/
+ (void)SKEyeSDK_ImageId:(NSString *)imageId imagePath:(NSString *)imagePath service_name:(SK_SERVICE_NAME*)serviceName callBack:(void(^)(id responseObject))callBack;

/*
 * 上传图片数据
 * 回调方式
 **/
+ (void)SKEyeSDK_Image:(UIImage *)image service_name:(SK_SERVICE_NAME*)serviceName callBack:(void(^)(id responseObject))callBack;

/*
 * 上传本地路径或者URL指向图片
 * 回调方式
 **/
+ (void)SKEyeSDK_ImagePath:(NSString *)imagePath service_name:(SK_SERVICE_NAME*)serviceName callBack:(void(^)(id responseObject))callBack;

/*
 * 上传图片数据
 * 非回调方式
 **/
+ (NSData *)SKEyeSDK_Image:(UIImage *)image service_name:(SK_SERVICE_NAME*)serviceName;

/*
 * 上传本地路径或者URL指向图片
 * 非回调方式
 **/
+ (NSData *)SKEyeSDK_ImagePath:(NSString *)imagePath service_name:(SK_SERVICE_NAME*)serviceName;

@end
