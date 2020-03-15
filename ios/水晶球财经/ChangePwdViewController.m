//
//  ChangePwdViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/11/6.
//  Copyright © 2015年 com.sjqcj. All rights reserved.


#import "ChangePwdViewController.h"
#import "UIViewExt.h"
@interface ChangePwdViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray* _ItemsArray;
}
@end

@implementation ChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APPBackColor;
    self.navigationItem.title = @"修改密码";
    // Do any additional setup after loading the view.
    [self initGloableData];
    [self buildUI];
}

-(void)initGloableData
{
    _ItemsArray =[[NSArray alloc]initWithObjects:@"原密码",@"新密码",@"再次输入新密码",nil];
}
-(void)buildUI
{
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    self.tableView.width = SCREENWIDTH;
    self.tableView.height = 180;
    self.tableView.left = 0;
    self.tableView.top = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    button.width = 100;
    button.height = 40;
    button.top = self.tableView.bottom + 40;
    button.centerX = SCREENWIDTH * 0.5;
    button.backgroundColor =  [UIColor grayColor];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.layer.cornerRadius = 7;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor orangeColor].CGColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* identifier = @"changeCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.width = SCREENWIDTH;
    cell.textLabel.text = [_ItemsArray objectAtIndex:indexPath.row];
    //创建TF
    UITextField* tf = [UITextField new];
    [cell addSubview:tf];
    tf.width = 250;
    tf.height = 40;
    tf.right = cell.width - 20;
    tf.centerY = cell.height * 0.5 + 10;
    tf.secureTextEntry = YES;
    tf.backgroundColor = [UIColor whiteColor];
    if(indexPath.row==0){
        [tf becomeFirstResponder];
        tf.placeholder = @"请输入原密码";
    }else if (indexPath.row==1){
        tf.placeholder = @"请输入新密码";
    }else if(indexPath.row==2){
        tf.placeholder = @"请再次输入新密码";
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


@end
