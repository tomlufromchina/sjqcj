//
//  BigManListTableViewCell.m
//  水晶球财经
//
//  Created by Tom lu on 15/10/29.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "BigManListTableViewCell.h"
#import "UIViewExt.h"
@implementation BigManListTableViewCell

- (void)awakeFromNib {
    
    self.width = SCREENWIDTH;
    
    self.addButton.right = self.width - 30;
    
    UIView* bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:bottomView];
    bottomView.height = 5;
    bottomView.width = self.width;
    bottomView.left = 0;
    bottomView.bottom = self.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
