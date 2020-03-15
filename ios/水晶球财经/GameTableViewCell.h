//
//  GameTableViewCell.h
//  水晶球财经
//
//  Created by 罗海方 on 15/11/23.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *rankLabel;  //排名

@property (weak, nonatomic) IBOutlet UIImageView *headImageView; //头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel; //名字


@property (weak, nonatomic) IBOutlet UILabel *constWeekLabel;  //参与周数
@property (weak, nonatomic) IBOutlet UILabel *weekCountLabel;   //参数周数



@property (weak, nonatomic) IBOutlet UILabel *weekScoreLabel; //周积分数
@property (weak, nonatomic) IBOutlet UILabel *allScoreLabel;  //总积分数

@property (weak, nonatomic) IBOutlet UILabel *constLabel0;//周积分
@property (weak, nonatomic) IBOutlet UILabel *constLabel1;//总积分

@property (weak, nonatomic) IBOutlet UIView *middleLineView;//分割线  左右8 point


@property (weak, nonatomic) IBOutlet UILabel *constLabel2; //股票
@property (weak, nonatomic) IBOutlet UILabel *constLabel3; //最新价
@property (weak, nonatomic) IBOutlet UILabel *constLabel4; //涨幅


//包含了股票 最新价， 涨幅 三个数据的View
@property (weak, nonatomic) IBOutlet UIView *stockDataView;

@property (weak, nonatomic) IBOutlet UILabel *stockNameLabel; //股票数
@property (weak, nonatomic) IBOutlet UILabel *newestPricesLabel;//最新价数
@property (weak, nonatomic) IBOutlet UILabel *updownLabel;//涨幅数

//---------------------------//
@property (weak, nonatomic) IBOutlet UIView *stockDataView1;

@property (weak, nonatomic) IBOutlet UILabel *stockNameLabel1;
@property (weak, nonatomic) IBOutlet UILabel *newestPricesLabel1;
@property (weak, nonatomic) IBOutlet UILabel *updownLabel1;


@end
