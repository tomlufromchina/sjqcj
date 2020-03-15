//
//  MakeCommentViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/11/16.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "MakeCommentViewController.h"
#import "FaceBoard.h"
#import "UIViewExt.h"
@interface MakeCommentViewController ()<UITextViewDelegate>
{
    UIView* _keyBoradSubView;
    UIButton* _faceButton;
    UIButton* _openImageButton;
    UIButton* _aiteButton;
    FaceBoard* _faceBoard;
}

@end

@implementation MakeCommentViewController

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
    
    //键盘已经隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.width = SCREENWIDTH;
    self.view.height = SCREENHEIGHT;
    self.textView.width = SCREENWIDTH;
    self.textView.backgroundColor = RGB(240, 240, 242);
    self.textView.text = @"写评论...";
    [self.textView becomeFirstResponder];
    if(self.navigationItem.title==nil){
     self.navigationItem.title = @"回复评论";
    }
    
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(OkButtonAction)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
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
    _faceButton.right = 40;
    [_faceButton addTarget:self action:@selector(faceButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //打开图片按钮
    _openImageButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_keyBoradSubView addSubview:_openImageButton];
    [_openImageButton setBackgroundImage:[UIImage imageNamed:@"打开图片"] forState:UIControlStateNormal];
    _openImageButton.width = _openImageButton.height = 30 ;
    _openImageButton.top = 10;
    _openImageButton.right = 200;
    [_openImageButton addTarget:self action:@selector(openButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
//    _aiteButton =[UIButton buttonWithType:UIButtonTypeCustom];
//    [_keyBoradSubView addSubview:_aiteButton];
//    [_aiteButton setBackgroundImage:[UIImage imageNamed:@"艾特"] forState:UIControlStateNormal];
//    _aiteButton.width = _openImageButton.height = 30 ;
//    _aiteButton.top = 10;
//    _aiteButton.right = 240;
//    [_aiteButton addTarget:self action:@selector(aiteButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //表情相关处理
    _faceBoard = [[FaceBoard alloc]init];
    _faceBoard.inputTextView = self.textView;
    [self.view addSubview:_faceBoard];
    _faceBoard.left = 0;
    _faceBoard.bottom = self.view.height-64;
    _faceBoard.hidden = YES;
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
   // _keyBoradSubView.bottom = self.view.frame.size.height + 50;
}



//表情库
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

-(void)OkButtonAction //完成按钮
{
    
}

-(void)openButtonAction //打开相册
{
    
}

-(void)aiteButtonAction //@某个人
{
    
}
@end
