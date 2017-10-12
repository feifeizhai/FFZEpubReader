//
//  JingGeOptionModel.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/7.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JingGeBaseModel.h"
@interface JingGeOptionModel : JingGeBaseModel
@property (strong, nonatomic) NSString *optionId;            //选项Id
@property (strong, nonatomic) NSString *optionTitle;         //选项标题
@property (strong, nonatomic) NSString *order;               //排序
@property (assign, nonatomic) NSString *isAnswer;                 //是否是正确答案
@property (strong, nonatomic) NSArray *imageUrls;            //暂时不用
@property (strong, nonatomic) NSMutableArray *imageUrlLists; //缩略图片
@property (strong, nonatomic) NSMutableArray *viewImageLists;//原图图片
@property (assign, nonatomic) NSString *optionLetter;        //
@end
