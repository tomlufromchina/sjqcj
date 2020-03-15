//
//  BigManTableViewCell.h
//  Crystal
//
//  Created by Tom lu on 15/10/27.
//  Copyright © 2015年 com.sjqcj. All rights reserved.


//  首页 牛人 cell

#import <UIKit/UIKit.h>

@interface BigManTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImageView; //头像
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;  //名字
@property (strong, nonatomic) IBOutlet UILabel *constLabel;  //介绍const
@property (strong, nonatomic) IBOutlet UILabel *describeLabel; //介绍内容
@property (strong, nonatomic) IBOutlet UIButton *addButton;  //加关注

@end
