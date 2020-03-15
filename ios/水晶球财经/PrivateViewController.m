//
//  PrivateViewController.m
//  水晶球财经
//
//  Created by 罗海方 on 15/11/18.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "PrivateViewController.h"
#import "UIViewExt.h"

@interface PrivateViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* _itemsArray;
}

@end

@implementation PrivateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"私信";
    // Do any additional setup after loading the view from its nib.
    
    [self buildUI];
    [self initGloableData];
    [self requestData]; //请求全部私信信息
    
    
}

-(void)buildUI
{
    self.tableView.width = SCREENWIDTH;
    self.tableView.height = SCREENHEIGHT;
    self.tableView.left = 0;
    self.tableView.top = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)initGloableData
{
    _itemsArray = [NSMutableArray new];
}

-(void)requestData
{
    _itemsArray = [NSMutableArray arrayWithObjects:@"信息",@"222222",@"3333333333333333", nil];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --  tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_itemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* identifier = @"privateCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [self createCell:indexPath cell:cell];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"我要删掉思懿";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //先删除data数据
        
        [_itemsArray removeObjectAtIndex:indexPath.row];
        //在进行提交删除
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)createCell:(NSIndexPath*)indexPath
             cell:(UITableViewCell*)cell
{
    //头像
    UIImageView* headImageView = [UIImageView new];
    headImageView.width = headImageView.height = 50;
    [cell addSubview:headImageView];
    headImageView.left = 8;
    headImageView.top = 8;
    headImageView.image = [UIImage imageNamed:@"user_head"];
    
    
    //名字
    UILabel* nameLabel = [UILabel new];
    [cell addSubview:nameLabel];
    nameLabel.width = SCREENWIDTH - SCREENWIDTH - 166;
    nameLabel.height = 20;
    nameLabel.left = 66;
    nameLabel.top = headImageView.top;
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.text = @"一只燕";
    
    
    //内容
    UITextView* textView = [UITextView new];
    [cell addSubview:textView];
    textView.width = SCREENWIDTH - 86;
    textView.height = 20;
    textView.left = nameLabel.left;
    textView.top = nameLabel.bottom + 10;
    textView.font = [UIFont systemFontOfSize:12];
    textView.text = @"喝酒喝酒喝酒喝酒喝酒喝酒啊啊啊";
    
    
    //时间
    UILabel* timeLabel = [UILabel new];
    [cell addSubview:timeLabel];
    timeLabel.top = headImageView.top;
    timeLabel.width = 100;
    timeLabel.height = 20;
    timeLabel.right = SCREENWIDTH - 20;
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.text = @"18:20";
    
    //底部View
    UIView* bottomLine = [UIView new];
    [cell addSubview:bottomLine];
    bottomLine.width =SCREENWIDTH;
    bottomLine.height = 1;
    bottomLine.backgroundColor =  [UIColor lightGrayColor];
    bottomLine.top = 65;
    
}




@end
