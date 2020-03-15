//
//  EditUserInfoViewController.h
//  水晶球财经
//
//  Created by Tom lu on 15/11/1.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "BaseViewController.h"

@interface EditUserInfoViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *line0View; //第1根线

@property (strong, nonatomic) IBOutlet UIImageView *headImageView; //head

@property (strong, nonatomic) IBOutlet UIView *lineView; //第2根线
@property (strong, nonatomic) IBOutlet UIView *line2View; //第3根线


@property (strong, nonatomic) IBOutlet UIButton *sexButton0; //按钮1
@property (strong, nonatomic) IBOutlet UIButton *sexButton1;  //按钮2

@property (strong, nonatomic) IBOutlet UILabel *constLabel0; //男
@property (strong, nonatomic) IBOutlet UILabel *constLabel1;  //女

@property (strong, nonatomic) IBOutlet UITextField *nameTF; //填写姓名
@property (strong, nonatomic) IBOutlet UITextView *textView; //填写简介


///////////////////需要传递过来的参数
@property(nonatomic,strong)NSString* old_name ;//用户名
@property(nonatomic,strong)UIImage* headImage;//头像
@property(nonatomic,assign)BOOL   sex; //性别
@property(nonatomic,strong)NSString* describStr; //描述
@end
