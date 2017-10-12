//
//  JingGeEpubReaderModel.m
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/19.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeEpubReaderModel.h"
#import <JingGeDataManager.h>
@implementation JingGeEpubReaderModel

- (instancetype)initWithFilePath:(NSString *)filePath {
    self = [super init];
    if (self) {
        //self.ID = @"1324654879794654686546";
        NSString *fileFullPath = filePath;
        NSString *fileName= [NSString stringWithFormat:@"%@", [[fileFullPath lastPathComponent] stringByDeletingPathExtension]];
        self.fileName = [NSString stringWithFormat:@"%d", [JingGeDataManager md5ToInteger:fileName]];
    }
    return self;
}

- (void)setFileName:(NSString *)fileName {
    _fileName = fileName;
    self.charName = [JingGeDataManager trimWhiteSpace:[JingGeDataManager chineseChangeChar:fileName]];
}



@end
