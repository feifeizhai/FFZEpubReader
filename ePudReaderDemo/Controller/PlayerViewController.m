//
//  PlayerViewController.m
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/27.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "PlayerViewController.h"
#import <JingGeMacro.h>
#import "KRVideoPlayerController.h"
@interface PlayerViewController ()
@property (nonatomic, strong) KRVideoPlayerController *videoController;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromHexAlpha(0x000000, 0.8);
    [self playVideoWithURL:self.URL];
    // Do any additional setup after loading the view.
}

- (void)playVideoWithURL:(NSString *)URL {
    
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, kScreenHeight / 2 - width*(9.0/16.0) / 2, width, width*(9.0/16.0))];
        
        
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
            [weakSelf dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
        [self.videoController showInWindow];
    }
    self.videoController.contentURL = [NSURL URLWithString:URL];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
