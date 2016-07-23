//
//  LGXMLParser.h
//  封装XML解析
//
//  Created by label on 15/11/5.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LGXMLParser;

@protocol LGXMLParserDelegate <NSObject>

/**
 *  代理返回解析完成的数据
 */
- (void)LGXMLParserData:(LGXMLParser *)XMLParserData result:(id)result;

@end

@interface LGXMLParser : UIViewController

/**xml节点*/
@property (strong, nonatomic) NSString *matchingElement;

@property (weak ,nonatomic) id<LGXMLParserDelegate> delegate;

/**
 *  传递数据给LGXMLParser解析
 */
- (void)LGXMLParserData:(NSData *)data;

@end
