//
//  BigManListViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/10/29.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "BigManListViewController.h"
#import "BigManTableViewCell.h"
#import "UIViewExt.h"
#import "UserCenterViewController.h" //跳转到用户中心
#import "UIImageView+WebCache.h"
#define Url_GetImage   @"http://www.sjqcj.com/data/upload/" //精华微博列表 图片获取

#define Url_GetImage1  @"http://www.sjqcj.com/data/upload/avatar"  //牛人列表 图片获取
#define ImageXX        @"original_200_200.jpg" //牛人列表图片200*200
#define ImageLL        @"original_100_100.jpg"//100*100
#define ImageSS        @"original_50_50.jpg"  //50*50
#define Imagess        @"original_30_30.jpg"  //30*30
#import "UserInfo.h"

@interface BigManListViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BigManListViewController
@synthesize tableView = _tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"牛人列表";
    // Do any additional setup after loading the view from its nib.
    
    _tableView.width = SCREENWIDTH;
    _tableView.height = SCREENHEIGHT - 66;
    _tableView.delegate = (id)self;
    _tableView.dataSource = (id)self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.bigManArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"xibCell2";
    UINib *nib=[UINib nibWithNibName:@"BigManTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    BigManTableViewCell* cell2 = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell2){
        cell2 = [[BigManTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    if(self.bigManArray.count>0){
        
        //处理头像
        NSString* middleStr = [[self.bigManArray objectAtIndex:indexPath.row]valueForKey:@"save_path"]; //中间参数
        NSString* imageUrlStr = [NSString stringWithFormat:@"%@%@%@",Url_GetImage1,middleStr,ImageLL];
        NSURL* imageUrl = [NSURL URLWithString:imageUrlStr];
        // [cell2.headImageView sd_setImageWithURL:imageUrl];
        [cell2.headImageView sd_setImageWithURL:imageUrl placeholderImage:PLACEHOLDERIMAGE];
        
        
        //处理用户名
        cell2.nameLabel.text = [[self.bigManArray objectAtIndex:indexPath.row]valueForKey:@"uname"];
        
        //处理介绍
        NSString* introStr = [[self.bigManArray objectAtIndex:indexPath.row]valueForKey:@"intro"];
        if([introStr isEqual:[NSNull null]] || introStr.length ==0 ){
            cell2.describeLabel.text = @"暂无介绍";
        }else{
            cell2.describeLabel.text = introStr;
        }
        
    }
    
    return cell2;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserCenterViewController* centerVC = [UserCenterViewController new];
    if([UserInfo sharedInfo].userId==nil){
        [self showAlert:nil message:@"请先登录"];
        return;
    }
    
    BOOL flag = [[[self.bigManArray objectAtIndex:indexPath.row]valueForKey:@"uid"] isEqual:[UserInfo sharedInfo].userId];
    if(flag){
        centerVC.isOtherPeople = NO;
    }else{
        centerVC.isOtherPeople = YES;
    }
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:centerVC animated:YES];
}


//提示框  这个方法 只能在当前类中使用
-(void)showAlert:(NSString*)title
         message:(NSString*)message
{
    if(title==nil){
        title = @"提示";
    }
    if(message==nil){
        message = @"正在开发...";
    }
    
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //点击取消的响应
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
    }];
    
    //点击确定的响应
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
