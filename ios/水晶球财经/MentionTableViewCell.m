//
//  MentionTableViewCell.m
//  水晶球财经
//
//  Created by 罗海方 on 15/11/23.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "MentionTableViewCell.h"
#import "UIViewExt.h"
@implementation MentionTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.width = SCREENWIDTH;
    self.backgroundColor = RGB(240, 240, 242);
    
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //处理底部线条   tableview的 cell 分割线 必须被取消!
    UIView* buttomLine = [UIView new];
    [self addSubview:buttomLine];
    buttomLine.backgroundColor = RGB(70.20, 51.70, 51.70);
    buttomLine.width = SCREENWIDTH;
    buttomLine.height = 1;
    buttomLine.left = 0;
    buttomLine.top = self.height - 1;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
