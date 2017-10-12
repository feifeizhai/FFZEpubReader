//
//  JingGeEpubReaderColorChoiseCollectionViewCell.m
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/8/2.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeEpubReaderColorChoiseCollectionViewCell.h"

@implementation JingGeEpubReaderColorChoiseCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.borderWidth = 2.0;
        self.contentView.layer.cornerRadius = 2.0;
        self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    }
    return self;
    
}

@end
