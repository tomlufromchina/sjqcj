//
//  LoginViewController.m
//  Crystal
//
//  Created by Tom lu on 15/10/27.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "LoginViewController.h"
#import "UIViewExt.h"
#import "EnrollViewController.h"
#import "CommonMethod.h"
#import "AFNetworking.h"
#import "UserInfo.h"
@interface LoginViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSDictionary* _usrsDic;  //本地保存用户信息的字典
    BOOL _isSaveInfo;  //是否保存用户信息
    
    
    UITableView* _moreUserTableView;  //显示更多用户账号
}

@end

@implementation LoginViewController

-(void)viewWillDisappear:(BOOL)animated
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //nav item 中间
    self.navigationItem.title = @"登录";
    
    
    //nav item 左边
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    //nav item 右边
    
         //自定义button
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 60, 30)];
    [button setBackgroundImage:[UIImage imageNamed:@"sign_button"] forState:UIControlStateNormal];
   [button setTitle:@"注册" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         //为button增加Target
    [button addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
         //创建Item，设置button为其CustomView
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];
         //Item设置Target
    [rightItem setTarget:self];
         // Item设置为navigationItem的右按钮
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.scrollView.backgroundColor = APPBackColor;
    
    
    [self.imageView setFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH * 0.35)];
    self.imageView.left = 0;
    self.imageView.top = 0;
    self.imageView.backgroundColor = [UIColor lightGrayColor];
    
    self.IdLabel.left = SCREENWIDTH * 0.1;
    self.IdLabel.top = self.imageView.bottom +20;
    self.pwdLabel.left = self.IdLabel.left;
    self.pwdLabel.top = self.IdLabel.bottom + 10;
    
    self.IdTF.top = self.IdLabel.top;
    self.IdTF.left = self.IdLabel.right+5;
    self.IdTF.width = SCREENWIDTH*0.6;
    self.IdTF.delegate = self;
    
    self.passWordTF.top = self.pwdLabel.top;
    self.passWordTF.left = self.pwdLabel.right+5;
    self.passWordTF.width = SCREENWIDTH*0.6;
    
    self.forgetButton.top = self.passWordTF.bottom + 10; //忘记密码按钮
    self.forgetButton.right = SCREENWIDTH - 20;
    
    
    //保存密码相关
    self.savePwdConstLabel.top = self.savePwdButton.top = self.forgetButton.top;
    self.savePwdConstLabel.left = self.pwdLabel.left;
    self.savePwdButton.left = self.savePwdConstLabel.right + 10;
    [self.savePwdButton addTarget:self action:@selector(savePwdButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //登录按钮相关
    self.loginButton.top = self.forgetButton.bottom + 30;
    self.loginButton.left = self.pwdLabel.left;
    self.loginButton.width = SCREENWIDTH - 2* self.pwdLabel.left;
    self.loginButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_button_back"]];
   
//    [self.loginButton addTarget:self action:@selector(LoginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.directButton.top = self.loginButton.bottom + 10;
    self.directButton.left = self.loginButton.left;
    self.directButton.width = self.loginButton.width;
    self.directButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_button_back"]];
//    [self.directButton addTarget:self action:@selector(directButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.lineView.top = self.directButton.bottom + 30;
    self.lineView.left = 0;
    self.lineView.width = SCREENWIDTH;
    UILabel* label = [UILabel new];
    label.text = @"快速登录";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:label];
    label.width = 80;
    label.height = 30;
    label.centerX = SCREENWIDTH * 0.5;
    label.centerY = self.lineView.centerY;
    
    self.weixinButton.top = self.lineView.bottom+30;
    self.weixinButton.left = self.weiboButton.right = 60;
    self.weixinButton.left = (SCREENWIDTH - 180) * 0.25;
    
    self.qqButton.top = self.weixinButton.top;
    self.qqButton.left = self.weixinButton.right + self.weixinButton.left;
    
    self.weiboButton.top = self.qqButton.top;
    self.weiboButton.left = self.qqButton.right + self.weixinButton.left;
  
   
    //在TF上面显示内容
    [self showContentInTextFeild];
}

-(void)showContentInTextFeild
{
    NSDictionary* User0 = [[NSUserDefaults standardUserDefaults]valueForKey:@"User0"];
    NSDictionary* User1 = [[NSUserDefaults standardUserDefaults]valueForKey:@"User1"];
    NSDictionary* User2 = [[NSUserDefaults standardUserDefaults]valueForKey:@"User2"];
    
    //如果有至少一个本地用户 记住密码这里 变为已经记住
    if(User0){
        [self performSelector:@selector(savePwdButtonAction) withObject:nil];
    }
    
    //判断两个tf 显示什么内容
    if(User2){
        self.IdTF.text = [User2 valueForKey:@"UserName"];
        self.passWordTF.text = [User2 valueForKey:@"UserPwd"];
        return;
    }
    if(User1){
        self.IdTF.text = [User1 valueForKey:@"UserName"];
        self.passWordTF.text = [User1 valueForKey:@"UserPwd"];
        return;
    }
    if(User0){
        self.IdTF.text = [User0 valueForKey:@"UserName"];
        self.passWordTF.text = [User0 valueForKey:@"UserPwd"];
        return;
    }
}

//记住密码
-(void)savePwdButtonAction
{
    UIImage* tempImage = self.savePwdButton.currentBackgroundImage;
    if([tempImage isEqual:[UIImage imageNamed:@"记住密码0"]]){ //显示钩钩
      [self.savePwdButton setBackgroundImage:[UIImage imageNamed:@"记住密码1"] forState:UIControlStateNormal];
        self.IdTF.text = nil;
        self.passWordTF.text = nil;
        _isSaveInfo = YES;
    }else{
        [self.savePwdButton setBackgroundImage:[UIImage imageNamed:@"记住密码0"] forState:UIControlStateNormal];
        _isSaveInfo = NO;
    }
    
}

//注册响应
-(void)rightButtonAction
{
    EnrollViewController*  enrollVC = [EnrollViewController new];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:enrollVC animated:YES];
}



#pragma mark -- ================登录按钮响应================
- (IBAction)loginBUttonAction:(id)sender {
    
    //[self.navigationController popViewControllerAnimated:YES];
    if([self isIdOk] && [self isPwdOk])
    {
      
        [self show];
        [self requestData];
    }else{
        [self showAlert:nil :@"请填写用户名或密码"];
    }
    
}


-(BOOL)isIdOk
{
    return self.IdTF.text.length > 0? YES : NO;
}

-(BOOL)isPwdOk
{
    return self.passWordTF.text.length > 0 ? YES : NO;
}


//直接体验
- (IBAction)directButtonAction:(id)sender {
    //正确代码
   [self.navigationController popViewControllerAnimated:YES];
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
#pragma mark -- 网络请求 登录================================
-(void)requestData  //登录请求
{
    
    //准备动作String
    NSString* url = [CommonMethod UrlAddAction:Url_Login];
    NSMutableDictionary* dic = [NSMutableDictionary new];
    NSString* idStr = self.IdTF.text;
    NSString* pwdStr = self.passWordTF.text;
    [dic setObject:idStr forKey:@"login_email"];//@"1061550505@qq.com"
    [dic setObject:pwdStr forKey:@"login_password"]; //@"12345678"
    [dic setObject:@"1" forKey:@"login_remember"];
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* dic = [CommonMethod serializdDictionaryWithResponseObject:responseObject];
       // NSLog(@"登录返回的json信息是:%@",dic);
        NSNumber* staus = [dic valueForKey:@"status"];
        if([staus isEqual:@1]){
            
         //保存用户信息到临时数据中
        [UserInfo sharedInfo].userName = self.IdTF.text;
        [UserInfo sharedInfo].userPwd = self.passWordTF.text;
        [UserInfo sharedInfo].userId = [dic valueForKey:@"uid"];
         
        if(_isSaveInfo==YES){//如果可以保存用户信息
         [self saveToLocalData]; //用户名 密码 保存到本地数据
        }
      
            
        [self showSuccess];
        [self.navigationController popViewControllerAnimated:YES];
        }else if ([staus isEqual:@0]){
            [self showError];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"登录请求错误:%@",error);
        [self showError];
    }];
}

-(int) countOfLocalSavedUser //获取本地保存的用户数
{
   NSDictionary* user0 = [[NSUserDefaults standardUserDefaults]valueForKey:@"User0"];
   NSDictionary* user1 = [[NSUserDefaults standardUserDefaults]valueForKey:@"User1"];
   NSDictionary* user2 = [[NSUserDefaults standardUserDefaults]valueForKey:@"User2"];
    
    if(user2){
        return 3;
    }
    if(user1){
        return 2;
    }
    if(user0){
        return 1;
    }
    else{
        return 0;
    }
    
}

-(BOOL)isChangeLocalSafty:(NSString*)currentUserName //插入或 替换 本地之前 判断 是否应该插入或替换
{
    int count = [self countOfLocalSavedUser];
    if(count == 0 ){ //如果没有用户，可以插入
        return YES;
    }
    for(int i = 0; i < count; i++) //如果用户名有相同的，不能插入
    {
        NSString* key = [NSString stringWithFormat:@"User%d",i];
        NSDictionary* user = [[NSUserDefaults standardUserDefaults]valueForKey:key];
        NSString* userName = [user valueForKey:@"UserName"];
        
        if([currentUserName isEqualToString:userName]){
            return NO;
        }
    }
    return YES; //执行完成以后没有同名的  可以插入或替换
}

-(void)saveToLocalData //用户名 密码 保存到本地数据库
{
    
    if([self countOfLocalSavedUser]== 0){ //0个用户数据
        //创建新用户
        NSMutableDictionary* User0 = [NSMutableDictionary new];
        [User0 setObject:self.IdTF.text forKey:@"UserName"]; //换成当前的TF数据
        [User0 setObject:self.passWordTF.text forKey:@"UserPwd"];
        [User0 setObject:[UserInfo sharedInfo].userId forKey:@"UserId"];
        
        [[NSUserDefaults standardUserDefaults]setObject:User0 forKey:@"User0"];
        
     }else{ //如果本地数据库已经保存了至少一个用户的信息
        if([self countOfLocalSavedUser] == 1){ //如果已经保存了一个用户信息
            //创建第2个用户信息
            NSMutableDictionary* User1 = [NSMutableDictionary new];
            [User1 setObject:self.IdTF.text forKey:@"UserName"];
            [User1 setObject:self.passWordTF.text forKey:@"UserPwd"];
            [User1 setObject:[UserInfo sharedInfo].userId forKey:@"UserId"];
            
            if([self isChangeLocalSafty:self.IdTF.text]){
                //插入新用户   用密码来判断是否是同一人
            [[NSUserDefaults standardUserDefaults]setObject:User1 forKey:@"User1"];
            }
            
        }
        if([self countOfLocalSavedUser] == 2){ //如果已经保存了两个用户的信息
            //增加第3个用户信息
            NSMutableDictionary* User2 = [NSMutableDictionary new];
            [User2 setObject:self.IdTF.text forKey:@"UserName"];
            [User2 setObject:self.passWordTF.text forKey:@"UserPwd"];
            [User2 setObject:[UserInfo sharedInfo].userId forKey:@"UserId"];
            
            //插入新用户
            if( [self isChangeLocalSafty:self.IdTF.text]){
            [[NSUserDefaults standardUserDefaults]setObject:User2 forKey:@"User2"];
            }
            
        }
         
        if([self countOfLocalSavedUser] == 3){  //如果已经保存了三个用户的信息
            //创建一个用户信息
            NSMutableDictionary* User0 = [NSMutableDictionary new];
            [User0 setObject:self.IdTF.text forKey:@"UserName"];
            [User0 setObject:self.passWordTF.text forKey:@"UserPwd"];
            [User0 setObject:[UserInfo sharedInfo].userId forKey:@"UserId"];
            
            //替换第一个用户
            if([self isChangeLocalSafty:self.IdTF.text]){
                [[[NSUserDefaults standardUserDefaults]valueForKey:@"Users"]removeObjectForKey:@"User0"];
                [[NSUserDefaults standardUserDefaults] setObject:User0 forKey:@"User0"];
            }
            
        }
    }
}

//提示框
-(void)showAlert:(NSString*)title :(NSString*)message
{
    if(title==nil){
        title = @"提示";
    }
    if(message==nil){
        message = @"该功能正在开发...";
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

#pragma mark textFeild delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    int localUserCount = [self countOfLocalSavedUser];
    
    if(localUserCount >= 2 && textField.text == nil)  //本地存储的用户数量超过两个人才显示列表
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self createTableView];
        });
    }
    
    return YES;
}

-(void)createTableView
{
    _moreUserTableView = [UITableView new];
    [self.scrollView addSubview:_moreUserTableView];
    _moreUserTableView.delegate = (id)self;
    _moreUserTableView.dataSource = (id)self;
    _moreUserTableView.width = self.IdTF.width;
    _moreUserTableView.height = self.IdTF.height * [self countOfLocalSavedUser] -1 ; //少显示一个
    _moreUserTableView.left = self.IdTF.left;
    _moreUserTableView.top = self.IdTF.bottom+2;
    _moreUserTableView.backgroundColor = [UIColor grayColor];
    _moreUserTableView.layer.cornerRadius = 8;
    _moreUserTableView.layer.borderColor = [UIColor greenColor].CGColor;
    _moreUserTableView.layer.borderWidth = 1;
    _moreUserTableView.scrollEnabled = NO;
    
}

#pragma mark -- tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self countOfLocalSavedUser] -1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"moreUserCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //处理头像
    UIImageView* imageView = [UIImageView new];
    [cell addSubview:imageView];
    imageView.width = imageView.height = 30;
    imageView.left = 10;
    imageView.centerY = cell.height * 0.5;
    imageView.image = [UIImage imageNamed:@"user_head"];
    
    //处理处理名字
    UILabel* userNameLabel = [UILabel new];
    [cell addSubview:userNameLabel];
    userNameLabel.width = 180;
    userNameLabel.height = 30;
    userNameLabel.left = imageView.right + 10;
    userNameLabel.centerY = cell.height * 0.5;
    userNameLabel.font = [UIFont systemFontOfSize:12];
    userNameLabel.textColor = [UIColor grayColor];
    
    //底部的线条
    UIView* bottomView = [UIView new];
    [cell addSubview:bottomView];
    bottomView.width = cell.width;
    bottomView.height = 1;
    bottomView.left = 0;
    bottomView.top = cell.bottom;
    bottomView.backgroundColor = [UIColor greenColor];
    
    NSString* key = [NSString stringWithFormat:@"User%lu",indexPath.row];
    NSDictionary* user = [[NSUserDefaults standardUserDefaults]valueForKey:key];
    userNameLabel.text = [user valueForKey:@"UserName"];
    return cell;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"ddd");
}
@end
