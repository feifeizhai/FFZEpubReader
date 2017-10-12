//
//  JingGePicReaderViewController.h
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/14.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeBaseViewController.h"
@interface PicReaderScrollView : UIScrollView

@end

@interface JingGePicReaderViewController : JingGeBaseViewController

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *imageFilePath;
@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UIColor *naviColor;
@property (strong, nonatomic) UIImage *backItemImage;

@end
