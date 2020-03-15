//
//  HotStockListViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/10/29.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "HotStockListViewController.h"
#import "HotStockListTableViewCell.h"
#import "UIViewExt.h"


#import "OneStockViewController.h" //跳转到某一个股票中
@interface HotStockListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HotStockListViewController
@synthesize tableView = _tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"股票列表";
    _tableView.delegate = (id)self;
    _tableView.dataSource = (id)self;
    _tableView.width = SCREENWIDTH;
    _tableView.height = SCREENHEIGHT - 66; //减去navigationBar高度
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"HotStockListCell";
    UINib *nib=[UINib nibWithNibName:@"HotStockListTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    HotStockListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[HotStockListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneStockViewController* oneStockVC = [OneStockViewController new];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:oneStockVC animated:YES];
}
@end
