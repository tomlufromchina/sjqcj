//
//  UserCenterViewController.h
//  水晶球财经
//
//  Created by Tom lu on 15/10/29.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "BaseViewController.h"

@interface UserCenterViewController : BaseViewController


////////////////////////////////////////initData
@property(nonatomic,assign)BOOL isOtherPeople; //是否是其它人进入个人中心

/////////////////////////////////////////UI

@property (strong, nonatomic) IBOutlet UIView *headerView; //tableview head

@property (strong, nonatomic) IBOutlet UIView *greenView; //显示简介 view
#pragma mark -- greenView包含下面所有元素
@property (strong, nonatomic) IBOutlet UIImageView *headImageView; //头像
@property (strong, nonatomic) IBOutlet UIImageView *sexImageView;  //性别
@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;   //昵称
@property (strong, nonatomic) IBOutlet UILabel *describLabel;   //描述
@property (strong, nonatomic) IBOutlet UILabel *constMoneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;   //水晶币
@property (strong, nonatomic) IBOutlet UIButton *creditInfoButton;


@property (strong, nonatomic) IBOutlet UIView *orangeView;
#pragma mark -- orangeView  包含下面所有元素

@property (strong, nonatomic) IBOutlet UIView *mentionView;   //关注大label
@property (strong, nonatomic) IBOutlet UILabel *mentionCountLabel;//关注数

@property (strong, nonatomic) IBOutlet UIView *fansView;  //粉丝大label
@property (strong, nonatomic) IBOutlet UILabel *fansCountLabel; //粉丝数

#pragma mark -- 下面三个按钮 属于header
@property (strong, nonatomic) IBOutlet UIButton *weiboButton;  //微博按钮
@property (strong, nonatomic) IBOutlet UILabel *weiBoCountLabel;


@property (strong, nonatomic) IBOutlet UIButton *selfChoiceButton;  //自选按钮
@property (strong, nonatomic) IBOutlet UIButton *investButton;  //投资组合按钮

@property (strong, nonatomic) IBOutlet UITableView *tableVIew;





@end
