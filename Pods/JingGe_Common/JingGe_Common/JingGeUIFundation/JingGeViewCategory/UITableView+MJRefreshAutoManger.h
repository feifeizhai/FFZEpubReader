//
//  UITableView+MJRefreshAutoManger.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/25.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MJRefresh;

typedef NS_ENUM(NSInteger, MJFooterRefreshState) {
    MJFooterRefreshStateNormal,
    MJFooterRefreshStateLoadMore,
    MJFooterRefreshStateNoMore
};
@interface UITableView (MJRefreshAutoManger)
@property (nonatomic,assign)MJFooterRefreshState footRefreshState;
@end
