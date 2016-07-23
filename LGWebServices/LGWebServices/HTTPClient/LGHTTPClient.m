//
//  JSHTTPClient.m
//  网络请求
//
//  Created by 李堪阶 on 15/11/1.
//  Copyright (c) 2015年 KJ. All rights reserved.
//

#import "LGHTTPClient.h"

@implementation LGHTTPClient

/**
 *  创建网络请求
 */
+ (LGHTTPClient *)shareInatance:(NSString *)soapMessage
{
        LGHTTPClient *clinet = [LGHTTPClient manager];
        
        clinet.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
        
        [clinet.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
       NSString *msgLength = [NSString stringWithFormat:@"%zd", [soapMessage length]];
        
        [clinet.requestSerializer setValue:msgLength forHTTPHeaderField:@"Content-Length"];
    
        [clinet.requestSerializer setQueryStringSerializationWithBlock:^NSString * (NSURLRequest * request, id parameters, NSError *  __autoreleasing * error) {
            return soapMessage;
        }];
    
    return clinet;
}

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
{
    
    [[self shareInatance:soapMessage] POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         failed(error);
    }];
    
//    [[self shareInatance:soapMessage] POST:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        
//        success(responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
//        failed(error);
//    }];
    
}


/**
 *  soap封装
 */
+ (NSString *)LGSoapMessage
{
    NSString *soap = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
    "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">";
    
    return soap;
}

@end
