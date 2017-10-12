//
//  JingGeEpubReaderModel.h
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/19.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JingGeEpubReaderCatalogModel.h"
#import "JingGeEpubReaderItemModel.h"
@interface JingGeEpubReaderModel : NSObject

@property (nonatomic, strong) NSString *filePath;       //epub 文件路径
@property (nonatomic, strong) NSString *fileName;       //epub 文件名称
@property (nonatomic, strong) NSString *charName;       //epub 文件拼音名称
@property (nonatomic, strong) NSString *unzipEpubFolder;//epub 解压文件路径
@property (nonatomic, strong) NSString *ID;       //epub 文件路径
@property (nonatomic, strong) NSString *manifestFilePath;//epub 核心文件
@property (nonatomic, strong) NSString *opfFilePath;     //epub 核心文件
@property (nonatomic, strong) NSString *ncxFilePath;     //epub 核心文件
@property (nonatomic, strong) NSMutableDictionary *epubInfo; //epub基本信息
@property (nonatomic, strong) NSMutableArray *epubCatalogs;  //epub目录信息
@property (nonatomic, strong) NSMutableArray *epubPageRefs;  //epub页码索引
@property (nonatomic, strong) NSMutableArray *epubPageItems; //epub页码信息
@property (nonatomic) NSNumber *pageRefIndex;    //当前页码索引
@property (nonatomic) NSNumber *offYIndexInPage; //页码内 滚动索引

- (instancetype)initWithFilePath:(NSString *)filePath ;

@end
