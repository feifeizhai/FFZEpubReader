//
//  JingGeEpubReaderCatalogModel.m
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/31.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeEpubReaderCatalogModel.h"

@implementation JingGeEpubReaderCatalogModel

- (NSString *)href {
    if (!_href) {
        _href = [[self.src componentsSeparatedByString:@"#"] firstObject];
    }
    return _href;
}

- (NSString *)fragmentID {
    if (!_fragmentID) {
        if ([self.src componentsSeparatedByString:@"#"].count > 1) {
            _fragmentID = [[self.src componentsSeparatedByString:@"#"] lastObject];
        }else {
            _fragmentID = 0;
        }
        
    }
    return _fragmentID;
}

@end
