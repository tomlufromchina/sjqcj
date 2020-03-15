//
//  StockGameViewController.h
//  水晶球财经
//
//  Created by 罗海方 on 15/11/23.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "BaseViewController.h"

@interface StockGameViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UIView *headerView; //包含了下面两个大的背景图fourButtonView + fourImageView

@property (weak, nonatomic) IBOutlet UIView *fourButtonView; //包含了4个按钮的View
@property (weak, nonatomic) IBOutlet UIButton *button0;     //实时赛况
@property (weak, nonatomic) IBOutlet UIButton *button1;     //当日涨幅榜
@property (weak, nonatomic) IBOutlet UIButton *button2;     //赛程报道
@property (weak, nonatomic) IBOutlet UIButton *button3;     //讨论区


@property (weak, nonatomic) IBOutlet UIView *fourImageView; //包含了4个UIImage的View
@property (weak, nonatomic) IBOutlet UIImageView *image0;   //总积分榜
@property (weak, nonatomic) IBOutlet UIImageView *image1;   //周积分榜
@property (weak, nonatomic) IBOutlet UIImageView *image2;   //断线榜
@property (weak, nonatomic) IBOutlet UIImageView *image3;   //人气榜

@property (weak, nonatomic) IBOutlet UILabel *label0;    //总积分榜
@property (weak, nonatomic) IBOutlet UILabel *label1;   //周积分榜
@property (weak, nonatomic) IBOutlet UILabel *label2;   //断线榜
@property (weak, nonatomic) IBOutlet UILabel *label3;   //人气榜


@property (weak, nonatomic) IBOutlet UITableView *tableView;  //tableview


@end
