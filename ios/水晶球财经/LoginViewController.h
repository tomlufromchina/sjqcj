//
//  LoginViewController.h
//  Crystal
//
//  Created by Tom lu on 15/10/27.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface LoginViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView; //大背景

@property (strong, nonatomic) IBOutlet UIImageView *imageView; //头部视图
@property (strong, nonatomic) IBOutlet UITextField *IdTF; // id
@property (strong, nonatomic) IBOutlet UITextField *passWordTF; //pwd

@property (strong, nonatomic) IBOutlet UILabel *savePwdConstLabel;//记住密码
@property (strong, nonatomic) IBOutlet UIButton *savePwdButton; //记住密码按钮



@property (strong, nonatomic) IBOutlet UIButton *forgetButton;  //忘记密码
@property (strong, nonatomic) IBOutlet UIButton *loginButton; //登录按钮
@property (strong, nonatomic) IBOutlet UIButton *directButton;  //直接体验

@property (strong, nonatomic) IBOutlet UILabel *IdLabel; //const0
@property (strong, nonatomic) IBOutlet UILabel *pwdLabel; //const1

@property (strong, nonatomic) IBOutlet UIView *lineView; //直接体验下方 横线

@property (strong, nonatomic) IBOutlet UIButton *weixinButton; //微信
@property (strong, nonatomic) IBOutlet UIButton *qqButton;  //qq
@property (strong, nonatomic) IBOutlet UIButton *weiboButton;  //微博


@end
