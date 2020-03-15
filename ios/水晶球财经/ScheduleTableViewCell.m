//
//  ScheduleTableViewCell.m
//  水晶球财经
//
//  Created by 罗海方 on 15/11/25.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "ScheduleTableViewCell.h"
#import "UIViewExt.h"
@implementation ScheduleTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.width = SCREENWIDTH;
    self.contentLabel.width = SCREENWIDTH - 16;
    self.timeLabel.left = self.contentLabel.left;
    self.countLabel.right = SCREENWIDTH - 20;
    self.constImageView.right = self.countLabel.left;
    
    //处理底部线条
    UIView* buttomView = [UIView new];
    buttomView.backgroundColor = [UIColor lightGrayColor];
    buttomView.width = SCREENWIDTH;
    buttomView.height = 1;
    buttomView.left = 0;
    buttomView.top = self.height - 1;
    [self addSubview:buttomView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
