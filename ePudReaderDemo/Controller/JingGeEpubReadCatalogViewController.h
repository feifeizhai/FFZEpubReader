//
//  JingGeEpubReadCatalogViewController.h
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/24.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <JingGe_Common/JingGe_Common.h>
@class JingGeEpubReadCatalogViewController, JingGeEpubReaderCatalogModel;
@protocol JingGeEpubReadCatalogViewControllerDelegate <NSObject>

@optional

- (void)catalogVC:(JingGeEpubReadCatalogViewController *)catalogVC didSelectAtModel:(JingGeEpubReaderCatalogModel *)model;

@end

@interface JingGeEpubReadCatalogViewController : JingGeBaseViewController

@property (nonatomic) NSInteger pageRefIndex;    //当前页码索引

@property (assign, nonatomic) id<JingGeEpubReadCatalogViewControllerDelegate> delegate;

@end
