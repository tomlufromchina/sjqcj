//
//  SettingViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/11/6.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "SettingViewController.h"
#import "UIViewExt.h"
#import "AboutUsViewController.h"
#import "IdBindViewController.h"
#import "ChangePwdViewController.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray* _settingItemsArray;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = APPBackColor;
    
    // Do any additional setup after loading the view from its nib.
    [self initGloableData];
    [self rebuildUI];
}

-(void)initGloableData
{
    _settingItemsArray = [[NSArray alloc]initWithObjects:@"",@"账号绑定",@"申请认证",@"修改密码",@"",@"意见反馈",@"关于我们", nil];
}
-(void)rebuildUI
{
    self.tableView.width = SCREENWIDTH;
    self.tableView.delegate = (id)self;
    self.tableView.dataSource = (id)self;
    self.tableView.height = 420;
    self.tableView.backgroundColor = APPBackColor;
    self.tableView.scrollEnabled = NO;
    
    self.logoutButton.centerX = SCREENWIDTH * 0.5;
    self.logoutButton.top =  self.tableView.bottom + 40;
//    self.logoutButton.layer.
   
    self.logoutButton.layer.cornerRadius = 8.0;
    self.logoutButton.layer.borderWidth = 1;
    self.logoutButton.backgroundColor = [UIColor orangeColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* identifier = @"SettingCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if(indexPath.row ==0 || indexPath.row == 4){
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = APPBackColor;
        cell.userInteractionEnabled = NO;
    }else{
        cell.textLabel.text = [_settingItemsArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0 || indexPath.row==4){
        return 20;
    }else
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.hidesBottomBarWhenPushed = YES;
    if(indexPath.row==1){//账号绑定
        IdBindViewController* bindVC = [IdBindViewController new];
        [self.navigationController pushViewController:bindVC animated:YES];
    }else if (indexPath.row==2){//申请认证
       
    }else if (indexPath.row==3){ //修改密码
        ChangePwdViewController* changeVC = [ChangePwdViewController new];
        [self.navigationController pushViewController:changeVC animated:YES];
    }else if(indexPath.row==5){//意见反馈
        
    }else if(indexPath.row==6){//关于我们
        AboutUsViewController* aboutVC = [AboutUsViewController new];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    
}

@end
