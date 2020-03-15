//
//  HotStockListTableViewCell.m
//  水晶球财经
//
//  Created by Tom lu on 15/10/29.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "HotStockListTableViewCell.h"
#import "UIViewExt.h"
@implementation HotStockListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    UIView* bottomView = [UIView new];
    [self addSubview:bottomView];
    bottomView.width =SCREENWIDTH;
    bottomView.height = 1;
    bottomView.backgroundColor = [UIColor lightGrayColor];
    bottomView.left = 0;
    bottomView.top = self.bottom;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
