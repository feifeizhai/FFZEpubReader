//
//  JingGeBaseViewController.m
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 17/4/18.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeBaseViewController.h"
//#import "JingGeNetWork.h"
#import "JingGeMacro.h"

#import "Masonry.h"

@interface JingGeBaseViewController ()



@end

@implementation JingGeBaseViewController


- (void)dealloc {
    [MobClick endLogPageView:self.title];
}

- (id)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}



- (id)initWithControllerGoBack:(viewControllerViewDidLoad)controllerGoBack
{
    self = [super init];
    if (self) {
        self.controllerGoBack = controllerGoBack;
    }
    return self;
}

- (void)viewDidLoad {
    
    self.view.backgroundColor = UIColorFromHex(0xffffff);
    [MobClick beginLogPageView:self.title];
    //kNaviTitleFont(18, [UIColor whiteColor]);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    //黑色
    //return UIStatusBarStyleDefault;
    //白色
    return UIStatusBarStyleLightContent;
}

- (UIImageView *)spaceImageView
{
    if (!_spaceImageView) {
        self.spaceImageView = [UIImageView new];
        [self.view addSubview:_spaceImageView];
        kWeakSelf(ws);
        [_spaceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(ws.view);
            make.size.mas_equalTo(CGSizeMake(563/2, 443/2));
        }];
        
    }
    return _spaceImageView;
}

- (UILabel *)spaceLable
{
    if (!_spaceLable) {
        self.spaceLable = [UILabel new];
        [self.view addSubview:_spaceLable];
        kWeakSelf(ws);
        [_spaceLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(ws.spaceImageView.mas_bottom).with.offset(kDefaultSpace);
            make.left.mas_equalTo(kDefaultSpace);
            make.right.mas_equalTo(kDefaultSpace);
            make.height.mas_equalTo(40);
            
        }];
        
    }
    return _spaceLable;
}

- (UIButton *)spaceBtn
{
    if (!_spaceBtn) {
        self.spaceBtn = [UIButton new];
        [self.view addSubview:_spaceBtn];
        kWeakSelf(ws);
        [_spaceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.spaceLable.mas_bottom).with.offset(kDefaultSpace);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(200);
        }];
        
    }
    return _spaceBtn;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (JingGeBaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[JingGeBaseTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableView.tableFooterView=[[UIView alloc]init];
    }
    return _tableView;
}

/**
 tableview datasource
 
 @param tableView <#tableView description#>
 @param section <#section description#>
 @return <#return value description#>
 */
- (NSInteger)b_tableView:(UITableView *_Nullable)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *_Nullable)b_TableView:(UITableView *_Nullable)tableView cellForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    return cell;
}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(self.title!=nil){
        [MobClick beginLogPageView:self.title];
    }
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if(self.title!=nil){
        [MobClick endLogPageView:self.title];
    }
}


- (void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
    if (self.controllerGoBack) {
        self.controllerGoBack(self);
    }
    
}

- (void)dismissBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    [super dismissViewControllerAnimated:flag completion:completion];
    if (self.controllerGoBack) {
        self.controllerGoBack(self);
    }
    
}

- (BOOL)shouldAutorotate
{
    return NO;
}

// 支持的屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
#pragma 没有数据时的占位图片
//数据为空时

//请求失败时


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
