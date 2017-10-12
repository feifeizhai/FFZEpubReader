//
//  JingGeEpubParser.h
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/19.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JingGeEpubReaderModel;
@interface JingGeEpubParser : NSObject

@property (strong, nonatomic) NSString *unzipEpubFolder;  //解压路径

@property (strong,nonatomic) NSString *lastError;

- (JingGeEpubReaderModel *)parserWithFilePath:(NSString *)filePath;
- (NSString*)HTMLContentFromFile:(NSString*)fileFullPath AddJsContent:(NSString*)jsContent;

@end
