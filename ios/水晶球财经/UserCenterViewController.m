//
//  UserCenterViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/10/29.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UIViewExt.h"
#import "WeiBoTableViewCell.h"//微博cell
#import "EditUserInfoViewController.h"//编辑资料
#import "SettingViewController.h"
#import "AFNetworking.h"
#import "CommonMethod.h"
#import "UserInfo.h"
#import "UIImageView+WebCache.h"
#import "UserInfo.h"

#import "MentionFansViewController.h" //跳转到关注 或者粉丝界面

@interface UserCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary* _currentUserData; //当前用户信息
}

@end

@implementation UserCenterViewController
@synthesize headerView = _headerView;
@synthesize greenView = _greenView;
@synthesize headImageView = _headImageView;
@synthesize sexImageView = _sexImageView;
@synthesize nickNameLabel =_nickNameLabel;
@synthesize describLabel = _describLabel;
@synthesize constMoneyLabel = _constMoneyLabel;
@synthesize moneyLabel = _moneyLabel;
@synthesize creditInfoButton = _creditInfoButton;
@synthesize orangeView = _orangeView;
@synthesize mentionView = _mentionView;
@synthesize fansView = _fansView;
@synthesize weiboButton = _weiboButton;
@synthesize selfChoiceButton = _selfChoiceButton;
@synthesize investButton = _investButton;
@synthesize tableVIew = _tableVIew;



-(void)viewDidAppear:(BOOL)animated
{
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group=dispatch_group_create();
   

    dispatch_group_async(group, queue, ^{
       // NSLog(@"顺序1--queue");
        [self requestUserData]; //获取用户信息
        if(self.isOtherPeople ==NO){
            [self requestUserMoneyData]; //获取水晶币
        }
    });
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
       // NSLog(@"顺序2--main");
        self.view.userInteractionEnabled = NO;
        [self show];
    });
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
       // NSLog(@"顺序3--main");
        self.view.userInteractionEnabled = YES;
    });

}


-(void)viewDidDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    self.headerView.width = SCREENWIDTH;
    self.headerView.backgroundColor = APPBackColor;
    
    
    _greenView.width = SCREENWIDTH;
    _orangeView.width = SCREENWIDTH;
    
    
    self.nickNameLabel.adjustsFontSizeToFitWidth = YES;
    
    //简介中的元素
    _moneyLabel.right = SCREENWIDTH - 20;
    _constMoneyLabel.right = _moneyLabel.left;
    
    //编辑资料
    _creditInfoButton.right = _moneyLabel.right;
    _creditInfoButton.backgroundColor = [UIColor grayColor];
    [_creditInfoButton addTarget:self action:@selector(creditInfoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //为橘色view 添加一跟竖线
    UIView*  middleLineView = [UIView new];
    middleLineView.backgroundColor = APPBackColor;
    middleLineView.width = 1;
    middleLineView.height = _orangeView.height;
    [_orangeView addSubview:middleLineView];
    middleLineView.left = SCREENWIDTH*0.5;
    
    
    //根据竖线  摆放 关注 和 粉丝 位置
    _mentionView.right = middleLineView.left - 40;
    UITapGestureRecognizer* tap0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mentionLabelAction)];
    _mentionCountLabel.userInteractionEnabled = YES;
    [_mentionView addGestureRecognizer:tap0];
    
    _fansView.left = middleLineView.right + 40;
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fansLabelAction)];
    _fansView.userInteractionEnabled = YES;
    [_fansView addGestureRecognizer:tap1];
    
    
    //重新摆放 三个按钮的位置
    _weiboButton.width = _selfChoiceButton.width = _investButton.width = 60;
    _weiboButton.left = (SCREENWIDTH - 180) * 0.25;
    _selfChoiceButton.left = _weiboButton.right + _weiboButton.left;
    _investButton.left = _selfChoiceButton.right + _weiboButton.left;
#pragma mark -- 这个版本 自选和投资组合先不做调整
    _weiboButton.centerX = SCREENWIDTH * 0.5 ;
    self.selfChoiceButton.hidden = YES; //这个版本先隐藏掉
    self.investButton.hidden = YES;    //这个版本先隐藏掉
    self.weiBoCountLabel.left = self.weiboButton.right;
   // self.weiBoCountLabel.text = @"(23)";
    
    
    //处理tableview
    _tableVIew.delegate = (id)self;
    _tableVIew.dataSource = (id)self;
    _tableVIew.width = SCREENWIDTH;
    _tableVIew.height = SCREENHEIGHT - _headerView.height - 66 ;
  // [_tableVIew setTableHeaderView:_headerView];
    _tableVIew.top = _headerView.bottom;
    //_tableVIew.backgroundColor = [UIColor redColor];
    
    self.view.backgroundColor = APPBackColor;
    
    /////////////////////////////////////////////////////
    
    [self rebuildUserCenter:self.isOtherPeople]; // 判断其它用户进入用户中心 _isMySelf参数带进去为了判断下一步如何构建UI
    [self initGloableData];
}


#pragma mark -- 判断是否是其它用户进入别人的用户中心  然后处理UI
-(void)rebuildUserCenter:(BOOL)isMySelf; //是否是自己进入了个人中心
{
    if(self.isOtherPeople==YES){  //其他人进入个人中心
        [self OtherPeopleSee];
    }else{ // 自己进入个人中心  不在处理UI了
        self.tableVIew.scrollEnabled = NO;
    }
    
    [self.tableVIew reloadData];
}

-(void)OtherPeopleSee
{
    self.navigationItem.title = @"牛人信息";
    self.constMoneyLabel.hidden = YES;
    self.moneyLabel.hidden = YES;
    self.creditInfoButton.hidden = YES;
    self.tableVIew.scrollEnabled = YES;
}

-(void)initGloableData
{
    _currentUserData = [NSDictionary new];
}

#pragma mark -- ================网络请求================
#pragma mark --获取当前用户数据
-(void)requestUserData
{
    NSString* url = [CommonMethod UrlAddAction:Url_UserInfo];
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    
    //处理没有登录的状态
    if([UserInfo sharedInfo].userId==nil){
        [self showAlert:@"提示" :@"请先登录"];
        return;
    }
    [parameterDic setObject:[UserInfo sharedInfo].userId forKey:@"mid"];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
        if(jsonDic.count > 0){
            _currentUserData = jsonDic[@"data"];
            
            //头像
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[_currentUserData valueForKey:@"avatar_big"]] placeholderImage:[UIImage imageNamed:@"man"]];
            //用户名
            self.nickNameLabel.text = [_currentUserData valueForKey:@"uname"];
            
            //性别
            self.sexImageView.image = [[_currentUserData valueForKey:@"sex"]  isEqual: @1] ? [UIImage imageNamed:@"男"] : [UIImage imageNamed:@"女"] ;
            
            //水晶币
            self.moneyLabel.text = @"0";
            
            //用户简介  [intro]
            NSString* intro = [_currentUserData valueForKey:@"intro"];
            if(intro==nil || [intro isEqual:[NSNull null]]){
                intro = @"暂无简介";
            }else{
                intro = [_currentUserData valueForKey:@"intro"];
            }
            self.describLabel.text = intro;
            
            //关注数
            NSString* mentionCount = [[_currentUserData valueForKey:@"Userdata"]valueForKey:@"following_count"];
            self.mentionCountLabel.text = [NSString stringWithFormat:@"%@",mentionCount];
            
            //粉丝数
           NSString* fansount = [[_currentUserData valueForKey:@"Userdata"]valueForKey:@"follower_count"];
            self.fansCountLabel.text = [NSString stringWithFormat:@"%@",fansount];
           
            
        }
        // NSLog(@"用户个人信息返回数据：%@",_currentUserData);
        //[self showSuccess];
        [self dismiss];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"用户信息请求错误%@",error);
        [self showError];
    }];

}

#pragma mark -- 获取用户财富信息
-(void)requestUserMoneyData
{
    
    if(![UserInfo sharedInfo].userId){
        return;
    }
    
    NSString* url = [CommonMethod UrlAddAction:Url_UserInfo_Money];
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    [parameterDic setObject:[UserInfo sharedInfo].userId forKey:@"mid"];
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
        if([jsonDic[@"status"] isEqual:@1]){
            NSString*money = [[[jsonDic[@"data"]valueForKey:@"credit"]valueForKey:@"shuijingbi"]valueForKey:@"value"];
            self.moneyLabel.text = [NSString stringWithFormat:@"%llu",money.longLongValue];
            //NSLog(@"水晶币请求返回数据位:%@",jsonDic);
        }
        [self dismiss];
       
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self showError];  //只显示失败 成功不显示了
        NSLog(@"水晶币请求错误%@",error);
       
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.isOtherPeople == YES){ //自己进入用户中心
        return 4;
    }else{  //非自己进入
        return 4;  //
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isOtherPeople == NO){//自己进入用户中心
        static NSString* identifier = @"NormalCell";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        NSArray* titleArray = @[@"猜大盘",@"我的比赛",@"收藏",@"设置"];
        cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
    }else{//别人 进入用户中心
        static NSString* identifier = @"weiboCell";
        UINib *nib=[UINib nibWithNibName:@"WeiBoTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
        
        WeiBoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell){
            cell = [[WeiBoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isOtherPeople==NO){ //别人进入用户中心
        return 50;
    }else{ //自己进入
        return 120;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if(self.isOtherPeople==NO){ //如果是其自己情况下
        if(indexPath.row==3)// 点击设置
        {
            SettingViewController* settingVC = [SettingViewController new];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:settingVC animated:YES];
        }
      
    }else{ //如果是别人
        
    }
    
}

#pragma mark--   自己编辑资料
-(void)creditInfoButtonAction
{
    EditUserInfoViewController* editVC = [EditUserInfoViewController new];
    self.hidesBottomBarWhenPushed = YES;
    editVC.old_name =  self.nickNameLabel.text;//把用户名 传递过去
    editVC.headImage =  self.headImageView.image; //头像传过去
    editVC.sex = [[_currentUserData valueForKey:@"sex"]  isEqual: @1] ? YES : NO ;
    editVC.describStr =  self.describLabel.text;
    [self.navigationController pushViewController:editVC animated:YES];
}

//提示框  这个方法 只能在当前类中使用
-(void)showAlert:(NSString*)title :(NSString*)message
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


#pragma mark -- 关注，粉丝 label 点击响应
-(void)mentionLabelAction
{
    MentionFansViewController* mentionFansVC = [MentionFansViewController new];
    self.hidesBottomBarWhenPushed = YES;
    mentionFansVC.titleForVC = @"关注";
    [self.navigationController pushViewController:mentionFansVC animated:YES];
}

-(void)fansLabelAction
{
    MentionFansViewController* mentionFansVC = [MentionFansViewController new];
    self.hidesBottomBarWhenPushed = YES;
    mentionFansVC.titleForVC = @"粉丝";
    [self.navigationController pushViewController:mentionFansVC animated:YES];
}

@end
