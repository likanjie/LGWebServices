//
//  JSHTTPClient.h
//  网络请求
//
//  Created by 李堪阶 on 15/11/1.
//  Copyright (c) 2015年 KJ. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

//成功回调
typedef void (^successBlock)(id data);
//失败回调
typedef void (^failedBlock)(NSError *error);
//错误回调
typedef void (^errorBlock)(id error);


@interface LGHTTPClient : AFHTTPSessionManager

/**
 *  创建网络请求
 */
+ (LGHTTPClient *)shareInatance:(NSString *)soapMessage;

/**
 *  POST请求
 *
 *  @param url     url
 *  @param param   请求参数
 *  @param success 成功的回调
 *  @param failed  失败的回调
 *  @param error   请求成功，但有错误信息的回调
 */
+ (void)LGPOST:(NSString *)url
     withParam:(id)param
withSoapMessage:(NSString *)soapMessage
withSuccessBlock:(successBlock)success
withFalieBlock:(failedBlock)failed
withErrorBlock:(errorBlock)error
;


/**
 *  soap封装
 */
+ (NSString *)LGSoapMessage;
@end
