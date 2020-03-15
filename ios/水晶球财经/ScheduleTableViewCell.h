//
//  ScheduleTableViewCell.h
//  水晶球财经
//
//  Created by 罗海方 on 15/11/25.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (weak, nonatomic) IBOutlet UIImageView *constImageView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@end
