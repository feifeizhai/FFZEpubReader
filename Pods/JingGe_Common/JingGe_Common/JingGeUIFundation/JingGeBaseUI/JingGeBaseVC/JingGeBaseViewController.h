//
//  JingGeBaseViewController.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 17/4/18.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMMobClick/MobClick.h"
#import "JingGeBaseTableView.h"

typedef void(^viewControllerViewDidLoad)(id sender);


@interface JingGeBaseViewController : UIViewController<JingGeTableViewDelegate, JingGeTableViewDataSource>
{
    JingGeBaseTableView *_tableView;
}
@property (strong, nonatomic) UIImageView *spaceImageView;
@property (strong, nonatomic) UILabel *spaceLable;
@property (strong, nonatomic) UIButton *spaceBtn;
//@property (strong, nonatomic) JingGeBaseTableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (copy, nonatomic) viewControllerViewDidLoad controllerGoBack;
- (id)initWithTitle:(NSString *)title;
- (id)initWithControllerGoBack:(viewControllerViewDidLoad)controllerGoBack;
- (void)popBack;
- (void)dismissBack;
@end
