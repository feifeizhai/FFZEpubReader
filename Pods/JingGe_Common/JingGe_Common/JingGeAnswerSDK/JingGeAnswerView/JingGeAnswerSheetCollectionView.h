//
//  JingGeAnswerSheetCollectionView.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/6.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingGeAnswerConfig.h"
@class JingGeAnswerSheetCollectionView ,JingGeAnswerModel;

@protocol  JingGeAnswerSheetCollectionViewDelegate<NSObject>
@optional
- (void)answerSheetView:(JingGeAnswerSheetCollectionView *)answerSheetView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (UICollectionReusableView *)answerSheetView:(JingGeAnswerSheetCollectionView *)answerSheetView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
- (void)answerSheetViewDidScroll:(UIScrollView *)scrollView;
@end

@interface JingGeAnswerSheetCollectionView : UICollectionView

@property (strong, nonatomic) JingGeAnswerModel *model;

@property (assign, nonatomic) id<JingGeAnswerSheetCollectionViewDelegate> sheetDelegate;

@property (strong, nonatomic) UICollectionViewFlowLayout *layout;

@property (strong, nonatomic) JingGeAnswerConfig *config;

@end
