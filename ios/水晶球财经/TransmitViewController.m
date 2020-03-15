//
//  TransmitViewController.m
//  水晶球财经
//
//  Created by 罗海方 on 15/11/17.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "TransmitViewController.h"
#import "FaceBoard.h"
#import "UIViewExt.h"
#import "CommonMethod.h"
#import "AFNetworking.h"
#import "UserInfo.h"
@interface TransmitViewController ()<UITextViewDelegate>
{
    UIView* _keyBoradSubView;
    UIButton* _faceButton;
    UIButton* _openImageButton;
    UIButton* _aiteButton;
    FaceBoard* _faceBoard;
}

@end

@implementation TransmitViewController


-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    //鍵盤将要出現
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
    
    //键盘将要隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.width = SCREENWIDTH;
    self.view.height = SCREENHEIGHT;
    self.textView.width = SCREENWIDTH;
    self.textView.backgroundColor = RGB(240, 240, 242);
    self.textView.text = @"说说分享心得...";

    [self.textView becomeFirstResponder];
    self.navigationItem.title = @"转发微博";
    
    
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(OkButtonAction)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(popButtonAction)];
    self.navigationItem.backBarButtonItem = leftBarButtonItem;
    
    // Do any additional setup after loading the view from its nib.
    [self buildUI];

}


-(void)buildUI
{
    self.textView.delegate = self;
    
    //增加键盘附加视图 动画显示效果
    _keyBoradSubView = [UIView new];
    [self.view addSubview:_keyBoradSubView];
    _keyBoradSubView.width = self.view.width;
    _keyBoradSubView.height = 50;
    _keyBoradSubView.left = 0;
    _keyBoradSubView.top = self.view.frame.size.height;
    _keyBoradSubView.layer.borderColor = RGB(221, 224, 227).CGColor;
    _keyBoradSubView.backgroundColor = RGB(249, 249, 249);
    
    //增加表情按钮按钮
    _faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_keyBoradSubView addSubview:_faceButton];
    [_faceButton setBackgroundImage:[UIImage imageNamed:@"笑脸"] forState:UIControlStateNormal];
    _faceButton.width = _faceButton.height = 30;
    _faceButton.top = 10;
    _faceButton.right = SCREENWIDTH-20;
    [_faceButton addTarget:self action:@selector(faceButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //打开图片按钮
    _openImageButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_keyBoradSubView addSubview:_openImageButton];
    [_openImageButton setBackgroundImage:[UIImage imageNamed:@"打开图片"] forState:UIControlStateNormal];
    _openImageButton.width = _openImageButton.height = 30 ;
    _openImageButton.top = 10;
    _openImageButton.left = 0+20;
    [_openImageButton addTarget:self action:@selector(openButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //艾特图片按钮
    _aiteButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_keyBoradSubView addSubview:_aiteButton];
    [_aiteButton setBackgroundImage:[UIImage imageNamed:@"艾特"] forState:UIControlStateNormal];
    _aiteButton.width = _aiteButton.height = 30 ;
    _aiteButton.top = 10;
    _aiteButton.left = SCREENWIDTH * 0.5 - 15;
    [_aiteButton addTarget:self action:@selector(aiteButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //表情相关处理
    _faceBoard = [[FaceBoard alloc]init];
    _faceBoard.inputTextView = self.textView;
    [self.view addSubview:_faceBoard];
    _faceBoard.left = 0;
    _faceBoard.bottom = self.view.height-64;
    _faceBoard.hidden = YES;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark -- 键盘通知回调
-(void)keyboardWillShown:(NSNotification*)aNotification
{
    NSLog(@"键盘要出现");
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    [UIView animateWithDuration:0.5 animations:^{
        _keyBoradSubView.bottom = self.view.frame.size.height - kbSize.height ;
    }];
    
}

-(void)keyboardWillHide:(NSNotification*)aNotification
{
    NSLog(@"键盘要隐藏了");
    _keyBoradSubView.bottom = self.view.frame.size.height + 50;
}



#pragma mark -- 打开表情库
-(void)faceButtonAction
{
    [self.textView resignFirstResponder];
    _faceBoard.hidden = NO;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textView resignFirstResponder];
    if(_faceBoard.hidden == NO){
        [_faceBoard setHidden:YES];
    }
}

-(void)openButtonAction //打开相册
{
    
}

-(void)aiteButtonAction //@某个人
{
    
}

#pragma mark ==========右上角 发送转发 ==========
-(void)OkButtonAction
{
    if(self.textView.text==nil){
        [self showAlert:nil message:@"说两句吧"];
    }else{
        [self uploadTransmitData];
    }
}

#pragma mark ========== 网络请求 ==========
#warning mark -- 暂时不能用“同时评论功能”

-(void)uploadTransmitData
{
    NSString* url = [CommonMethod UrlAddAction:Url_Post_Forward];
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    [parameterDic setObject:[UserInfo sharedInfo].userId forKey:@"mid"];
    [parameterDic setObject:[UserInfo sharedInfo].userPwd forKey:@"login_password"];
    [parameterDic setObject:self.feed_id forKey:@"feed_id"];
    [parameterDic setObject:self.textView.text forKey:@"body"];
     [parameterDic setObject:@"0" forKey:@"comment"];  //暂时不同时转发
    
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
        NSLog(@"%@",jsonDic);
        if([jsonDic[@"status"] isEqual:@1]){
            [self showAlert:nil message:@"转发成功!"];
        }
        [self dismiss];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self showError];  //只显示失败 成功不显示了
        NSLog(@"转发微博操作返回错误%@",error);
    }];

}


-(void)popButtonAction
{
    [self.navigationController popoverPresentationController];
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

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"11");
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"22");
}
@end
