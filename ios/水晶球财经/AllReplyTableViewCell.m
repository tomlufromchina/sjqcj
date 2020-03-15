//
//  AllReplyTableViewCell.m
//  水晶球财经
//
//  Created by Tom lu on 15/10/29.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "AllReplyTableViewCell.h"
#import "UIViewExt.h"
@implementation AllReplyTableViewCell




- (void)awakeFromNib {
    // Initialization code
    self.width = SCREENWIDTH;
    self.floorLabel.right = self.width - 20;
    
    
    
    //webView
    self.textView.left = self.nameLabel.left;
    self.textView.top = self.nameLabel.bottom + 2;
    self.textView.width = self.width - self.nameLabel.left - 20; //宽度=总宽度-左边-右边
    self.textView.height = 45;  //后面会动态变化
//    
//    
//    //处理最下面一排 
    
    self.createTimeLabel.left = self.textView.left;
    self.speakButton.right = self.right - 20;
    self.RePostButton.right = self.speakButton.left - 30;
    
    self.createTimeLabel.centerY = self.speakButton.centerY =self.RePostButton.centerY = self.textView.centerY + 53;//xib增量
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
