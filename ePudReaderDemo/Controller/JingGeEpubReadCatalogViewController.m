//
//  JingGeEpubReadCatalogViewController.m
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/24.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeEpubReadCatalogViewController.h"
#import "JingGeEpubReaderCotalogViewCell.h"
#import <JingGeNavigationBar.h>
#import "JingGeEpubReaderCatalogModel.h"
@interface JingGeEpubReadCatalogViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *catalogView;
@property (strong, nonatomic) JingGeNavigationBar *naviBar;
@property (strong, nonatomic) UIButton *backBtn;

@end

@implementation JingGeEpubReadCatalogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    [self subviewsLayout];
    [self addAction];
    // Do any additional setup after loading the view.
}

- (void)addSubviews {
    [self.view addSubview:self.naviBar];
    [self.view addSubview:self.catalogView];
}

- (void)subviewsLayout {
    [_naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.leading.trailing.mas_equalTo(0);
        make.height.mas_equalTo(kNavigationBar_HEIGHT + kStatusBar_HEIGHT);
    }];
    
    [_catalogView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_naviBar.mas_bottom);
        make.leading.trailing.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)addAction {
    [_backBtn addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backItemAction:(UIButton *)btn {
    [self dismissBack];
}

#pragma mark tableViewDatasourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JingGeEpubReaderCotalogViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JingGeEpubReaderCotalogViewCell class])];
    
    if (!cell) {
        
        cell = [[JingGeEpubReaderCotalogViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([JingGeEpubReaderCotalogViewCell class])];
        [cell subViewsLayout];
        
    }
    
    JingGeEpubReaderCatalogModel *catalogModel = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.mainLable.text = catalogModel.text;
    
    return cell;
}

#pragma mark TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.pageRefIndex = indexPath.row;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(catalogVC:didSelectAtModel:)]) {
        [self.delegate catalogVC:self didSelectAtModel:[self.dataArray objectAtIndex:indexPath.row]];
    }
    
    [self dismissBack];
}

#pragma mark 懒加载
- (UITableView *)catalogView {
    if (!_catalogView) {
        
        _catalogView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _catalogView.delegate = self;
        _catalogView.dataSource = self;
        
    }
    return _catalogView;
}

- (JingGeNavigationBar *)naviBar {
    if (!_naviBar) {
        _naviBar = [JingGeNavigationBar new];
        _naviBar.backgroundColor = [UIColor blueColor];
        _naviBar.backItem = self.backBtn;
    }
    return _naviBar;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
    }
    return _backBtn;
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
