//
//  MentionFansViewController.m
//  水晶球财经
//
//  Created by 罗海方 on 15/11/23.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "MentionFansViewController.h"
#import "MentionTableViewCell.h"
#import "UIViewExt.h"
#import "AFNetworking.h"
#import "CommonMethod.h"
#import "UserInfo.h"
#import "UIImageView+WebCache.h"
@interface MentionFansViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* _itemsArray;
}

@end

@implementation MentionFansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.titleForVC;
    // Do any additional setup after loading the view from its nib.
    [self buildUI];
    [self initGloableData];
    [self show];
    if([self.titleForVC isEqualToString:@"关注"]){
        [self requestMentionData]; //获取关注数据
    }else{
        [self requestFansData]; //获取粉丝数据
    }
}


-(void)buildUI
{
    self.tableView.width = SCREENWIDTH;
    self.tableView.height = SCREENHEIGHT - 64;
    self.tableView.left = 0;
    self.tableView.top = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)initGloableData
{
    _itemsArray = [NSMutableArray new]; //牛魔王
}

#pragma mark -- ===============网络请求===============
-(void)requestMentionData //获取我的关注列表数据
{
    NSString* url = [CommonMethod UrlAddAction:Url_UserInfo_MyCareList];
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    
    [parameterDic setObject:[UserInfo sharedInfo].userId forKey:@"mid"];
    [parameterDic setObject:[UserInfo sharedInfo].userPwd forKey:@"login_password"];
    

    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
        
       // NSLog(@"%@",jsonDic);
        if([jsonDic[@"status"]isEqual:@1]){
            _itemsArray = [[jsonDic[@"data"]valueForKey:@"followGroupList"]valueForKey:@"data"];
            [self.tableView reloadData];
        }
       
        [self dismiss];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self showError];  //只显示失败 成功不显示了
        NSLog(@"发出的评论请求错误%@",error);
    }];
}

-(void)requestFansData  //获取粉丝数据
{
    NSString* url = [CommonMethod UrlAddAction:Url_UserInfo_MyFansList];
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    
    [parameterDic setObject:[UserInfo sharedInfo].userId forKey:@"mid"];
    [parameterDic setObject:[UserInfo sharedInfo].userPwd forKey:@"login_password"];
    
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
        
        // NSLog(@"%@",jsonDic);
        if([jsonDic[@"status"]isEqual:@1]){
            _itemsArray = [[jsonDic[@"data"]valueForKey:@"followerList"]valueForKey:@"data"];
            [self.tableView reloadData];
        }
        
        [self dismiss];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self showError];  //只显示失败 成功不显示了
        NSLog(@"发出的评论请求错误%@",error);
    }];

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

#pragma mark -- tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_itemsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"MentionTableViewCell";
    UINib *nib=[UINib nibWithNibName:@"MentionTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    MentionTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[MentionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSDictionary* onePeople = [_itemsArray objectAtIndex:indexPath.row];
    
    
    NSString* name = [onePeople valueForKey:@"uname"]; //名字
    NSString* headUrlStr = [onePeople valueForKey:@"avatar_big"]; //头像url
    NSString* descripStr = [onePeople valueForKey:@"intro"];   //描述
    if([descripStr isEqual:[NSNull null]] || [descripStr isEqualToString:@""]){
        descripStr = @"暂无简介";
    }
    
   
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:headUrlStr]];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",name];
    cell.describLabel.text = [NSString stringWithFormat:@"%@",descripStr];;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
@end
