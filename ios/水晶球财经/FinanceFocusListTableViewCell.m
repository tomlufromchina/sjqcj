//
//  FinanceFocusListTableViewCell.m
//  水晶球财经
//
//  Created by Tom lu on 15/11/3.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "FinanceFocusListTableViewCell.h"
#import "UIViewExt.h"
@implementation FinanceFocusListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.width = SCREENWIDTH;
    self.commentCountLabel.right = self.width - 10;
    self.const1Label.right = self.commentCountLabel.left;
    self.readCountLabel.right = self.const1Label.left - 40;
    self.const0Label.right = self.readCountLabel.left;
    
    //底部线
    UIView* bottomView = [UIView new];
    [self addSubview:bottomView];
    bottomView.backgroundColor = APPBackColor;
    bottomView.width = self.width;
    bottomView.height = 1;
    bottomView.left = 0;
    bottomView.top = self.bottom;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
