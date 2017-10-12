//
//  JingGeEpubReaderInfoModel.h
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/31.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JingGeBaseModel.h>
@interface JingGeEpubReaderInfoModel : JingGeBaseModel

@property (strong, nonatomic) NSString *creator;
@property (strong, nonatomic) NSString *contributor;
@property (strong, nonatomic) NSString *language;
@property (strong, nonatomic) NSString *meta;
@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *title;

@end
