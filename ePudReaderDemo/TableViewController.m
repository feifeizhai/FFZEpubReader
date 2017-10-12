//
//  TableViewController.m
//  ePudReaderDemo
//
//  Created by 景格_徐薛波 on 2017/7/27.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "TableViewController.h"
#import "JingGeEpubReadViewController.h"
#import <MBProgressHUD.h>
@interface TableViewController ()

@property (strong, nonatomic) NSArray *bookList;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.bookList = @[@"这些", @"为人处世曾国藩", @"张爱玲作品集", @"测试(1)", @"1234456", @"新能源汽车使用与维护2"];
    //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    NSArray *fontlist = [JingGeDataManager fontLists];
    //NSLog(@"%@", [JingGeDataManager fontLists]);
    UIFont *font = [UIFont systemFontOfSize:14];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.bookList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [self.bookList objectAtIndex:indexPath.row];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *name = [self.bookList objectAtIndex:indexPath.row];
    
    NSString *fileFullPath=[[NSBundle mainBundle] pathForResource:name ofType:@"epub" inDirectory:nil];
    
    JingGeEpubReadViewController *readVC = [[JingGeEpubReadViewController alloc]initWithControllerGoBack:^(id sender) {
        
    }];
    readVC.fileFullPath = fileFullPath;
    
    [self.navigationController pushViewController:readVC animated:YES];
    /*
    [self presentViewController:readVC animated:YES completion:^{
        [MBProgressHUD hideHUDForView:ws.view animated:YES];
    }];
    */
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}


@end
