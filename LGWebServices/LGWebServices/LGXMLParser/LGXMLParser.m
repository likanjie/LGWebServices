//
//  LGXMLParser.m
//  封装XML解析
//
//  Created by label on 15/11/5.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "LGXMLParser.h"
@interface LGXMLParser ()<NSXMLParserDelegate>

/**拼接XML数据*/
@property (strong, nonatomic) NSMutableString *soapResults;

/**XML*/
@property (strong, nonatomic) NSXMLParser *xmlParser;

/**标记节点*/
@property (nonatomic,assign) BOOL elementFound;


@end

@implementation LGXMLParser

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)LGXMLParserData:(NSData *)data
{
    _xmlParser = [[NSXMLParser alloc] initWithData: data];
    
    [_xmlParser setDelegate: self];
    [_xmlParser setShouldResolveExternalEntities: YES];
    [_xmlParser parse];
}



#pragma mark - XML解析
//准备解析
- (void)parserDidStartDocument:(NSXMLParser *)parser
{

}

// 开始解析一个元素名
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {

    if ([elementName isEqualToString:_matchingElement]) {
        if (!_soapResults) {
            _soapResults = [[NSMutableString alloc] init];
        }
        _elementFound = YES;
    }
}

// 追加找到的元素值，一个元素值可能要分几次追加
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string {

    if (_elementFound) {
        [_soapResults appendString: string];
    }
}

// 结束解析这个元素名
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

    if ([elementName isEqualToString:_matchingElement]) {
        
        if ([self.delegate respondsToSelector:@selector(LGXMLParserData:result:)]) {
            
            [self.delegate LGXMLParserData:self result:_soapResults];
        }
        
        _elementFound = FALSE;
        // 强制放弃解析
        [_xmlParser abortParsing];
    }
    
}

// 解析整个文件结束后
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    if (_soapResults) {
        _soapResults = nil;
    }
}

// 出错时，例如强制结束解析
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (_soapResults) {
        _soapResults = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
