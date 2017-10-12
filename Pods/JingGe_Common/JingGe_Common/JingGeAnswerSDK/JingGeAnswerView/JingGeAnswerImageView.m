//
//  JingGeAnswerImageView.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/13.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeAnswerImageView.h"
#import "JingGeMacro.h"
#import "UIImageView+WebCache.h"
#import "JingGeDataManager.h"
#define kSimgleImageWidth kScreenWidth - 55
#define kDoubleImageWidth (kScreenWidth - 45) / 2


@interface JingGeAnswerImageView ()<UIGestureRecognizerDelegate>


@property (strong, nonatomic) NSMutableArray *viewArray;

@end

@implementation JingGeAnswerImageView

- (instancetype)initWithImageNames:(NSArray *)imageNames {
    self = [super init];
    if (self) {
        _imageNames = imageNames;
        [self addSubviews];
    }
    return self;
}


- (void)setImageNames:(NSArray *)imageNames {
    
    
    
    if (_imageNames.count == imageNames.count) {
        _imageNames = imageNames;
        return;
    }
    _imageNames = imageNames;
    [self addSubviews];
}


- (void)addSubviews {
    UIView *lastView;
    
    // UIViewController *currentVC = [JingGeDataManager getCurrentVC];
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0; i < _imageNames.count; i ++) {
        UIImageView *imageView = [self imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 100 + i;
        [imageView sd_setImageWithURL:[_imageNames objectAtIndex:i] placeholderImage:kGetImage(@"") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
        
        [self addSubview:imageView];
        [self.viewArray addObject:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        tap.delegate = self;
        [imageView addGestureRecognizer:tap];
        
        if (_imageNames.count == 1) {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.left.mas_equalTo(27.5);
                make.right.mas_equalTo(-27.5);
                make.width.mas_equalTo(kSimgleImageWidth);
                make.height.mas_equalTo((kScreenWidth - 55) / 1.6);
                //make.bottom.mas_equalTo(-15);
                //make.height.mas_equalTo(100);
            }];
        }else {
            NSInteger a = i / 2;
            NSInteger b = i % 2;
            if (b) {
                [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo (a * ((kScreenWidth / 2 - 22.5) / 1.6 + 15) + 15);
                    make.right.mas_equalTo( - 15);
                    make.width.mas_equalTo(kDoubleImageWidth);
                    make.height.mas_equalTo((kScreenWidth / 2 - 22.5) / 1.6);
                    // make.bottom.mas_equalTo(-15);
                }];
            }else {
                [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo (a * ((kScreenWidth / 2 - 22.5) / 1.6 + 15) + 15);
                    make.left.mas_equalTo(15);
                    make.width.mas_equalTo(kDoubleImageWidth);
                    make.height.mas_equalTo((kScreenWidth / 2 - 22.5) / 1.6);
                    // make.bottom.mas_equalTo(-15);
                }];
            }
            
            
        }
        lastView = imageView;
        //imageView.contentMode = UIViewContentModeScaleToFill;
    }
}

- (NSMutableArray *)viewArray {
    if (!_viewArray) {
        _viewArray = [NSMutableArray array];
    }
    return _viewArray;
}

- (UIImageView *)imageView {
    UIImageView *imageView = [[UIImageView alloc]initWithImage:kGetImage(@"")];
    imageView.backgroundColor = UIColorFromHex(0xf6f6f6);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    
    return imageView;
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    UIImageView *imageView = (UIImageView *)tap.view;
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickImageView:image:index:)]) {
        [self.delegate clickImageView:self image:imageView.image index:imageView.tag - 100];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
