//
//  PostListViewController.h
//  水晶球财经
//
//  Created by Tom lu on 15/10/28.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "BaseViewController.h"

@interface PostListViewController : BaseViewController


@property (strong, nonatomic) IBOutlet UIView *topLineView; //第一根线

@property (strong, nonatomic) IBOutlet UIButton *allButton;  //全部
@property (strong, nonatomic) IBOutlet UIButton *bigPanButton; //大盘
@property (strong, nonatomic) IBOutlet UIButton *someStockButton; //个股
@property (strong, nonatomic) IBOutlet UIButton *lunDaoButton;//论道
@property (strong, nonatomic) IBOutlet UIButton *famousButton;//名家
@property (strong, nonatomic) IBOutlet UIButton *fuShengButton;//浮生

@property (strong, nonatomic) IBOutlet UIView *lineView; //第二根线

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
