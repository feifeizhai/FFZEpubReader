//
//  JingGeEpubReaderCatalogModel.h
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/31.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JingGeBaseModel.h>
@interface JingGeEpubReaderCatalogModel : JingGeBaseModel
@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *src;
@property (strong, nonatomic) NSString *href;
@property (strong, nonatomic) NSString *fragmentID;
@property (strong, nonatomic) NSString *playOrder;
@end
