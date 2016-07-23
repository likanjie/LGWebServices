//
//  ViewController.m
//  LGWebServices
//
//  Created by 李堪阶 on 16/7/23.
//  Copyright © 2016年 DM. All rights reserved.
//

#import "ViewController.h"
#import "LGXMLParser.h"
#import "LGHTTPClient.h"

#define WebServicesURL @"http://webservice.webxml.com.cn/WebServices/MobileCodeWS.asmx"

@interface ViewController ()<LGXMLParserDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (IBAction)clickSureBtn {
    
    [self getData];
}

/**
 *  网络请求
 */
- (void)getData{
    
    //创建soap信息
    NSString *methodName = [NSString stringWithFormat:@"<soap12:Body>"
                            "<getMobileCodeInfo xmlns=\"http://WebXml.com.cn/\">"
                            "<mobileCode>%@</mobileCode>"
                            "<userID>%@</userID>"
                            "</getMobileCodeInfo>"
                            "</soap12:Body>"
                            "</soap12:Envelope>", self.phoneTextField.text,@""];
    
    //封装soap
    NSString *soapMessage = [[LGHTTPClient LGSoapMessage]stringByAppendingString:methodName];
    
    //网络请求
    [LGHTTPClient LGPOST:WebServicesURL withParam:soapMessage withSoapMessage:soapMessage withSuccessBlock:^(id data) {
       
        //XML解析
        LGXMLParser *xmlParser = [[LGXMLParser alloc]init];
        xmlParser.matchingElement = @"getMobileCodeInfoResult";
        xmlParser.delegate = self;
        [xmlParser LGXMLParserData:data];
        
        
    } withFalieBlock:^(NSError *error) {
        NSLog(@"失败回调%@",error);
    } withErrorBlock:^(id error) {
        NSLog(@"失败回调%@",error);
    }];
}

//XML解析回调
- (void)LGXMLParserData:(LGXMLParser *)XMLParserData result:(id)result{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请求结果" message:result preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
