//
//  JingGeOptionModel.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/7.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeOptionModel.h"

@implementation JingGeOptionModel

- (NSMutableArray *)imageUrlLists {
    if (!_imageUrlLists) {
        _imageUrlLists = [NSMutableArray array];
    }
    return _imageUrlLists;
}

- (NSMutableArray *)viewImageLists {
    if (!_viewImageLists) {
        _viewImageLists = [NSMutableArray array];
    }
    return _viewImageLists;
}


@end
