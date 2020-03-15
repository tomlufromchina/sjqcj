//
//  MessageViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/10/28.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "MessageViewController.h"
#import "UIViewExt.h"
#import "ReceivedCommentViewController.h"
#import "TweetedViewController.h"
#import "AiTeMeViewController.h"
#import "PrivateViewController.h"

@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray* _itemArray;
}
@end

@implementation MessageViewController


-(void)viewDidDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    self.view.backgroundColor = APPBackColor;
    // Do any additional setup after loading the view from its nib.
    self.tableVIew.width = SCREENWIDTH;
    self.tableVIew.top = 0  ;
    self.tableVIew.left = 0;
    self.tableVIew.height = 300;
    self.tableVIew.delegate = (id)self;
    self.tableVIew.dataSource = (id)self;
    self.tableVIew.scrollEnabled = NO;
    _itemArray = [[NSArray alloc]initWithObjects:@"收到的评论",@"发出的评论",@"@提到我的",@"我的私信",@"系统消息", nil];
    
    
    [self.tableVIew reloadData];
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

#pragma mark -- tableview delegete
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_itemArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"messageCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [_itemArray objectAtIndex:indexPath.row];
    
    
    if(indexPath.row==3){
        UIImageView* messageImageView = [UIImageView new];
        [cell addSubview:messageImageView];
        messageImageView.width = messageImageView.height = 10;
        messageImageView.left = 5;
        messageImageView.centerY = cell.height * 0.5;
        
        messageImageView.image = [UIImage imageNamed:@"有新消息"];
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row ==0 ){//收到的评论
        ReceivedCommentViewController* receivedVC = [ReceivedCommentViewController new];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:receivedVC animated:YES];
    }else if(indexPath.row == 1){
        TweetedViewController* tweetVC = [TweetedViewController new];
         self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tweetVC animated:YES];
    }else if(indexPath.row == 2){
        AiTeMeViewController* AiTeVC = [AiTeMeViewController new];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:AiTeVC animated:YES];
    }else if (indexPath.row==3){
        PrivateViewController* privateVC = [PrivateViewController new];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:privateVC animated:YES];
    }
}
@end
