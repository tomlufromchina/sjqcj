//
//  WeiBoTableViewCell.m
//  水晶球财经
//
//  Created by Tom lu on 15/10/30.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "WeiBoTableViewCell.h"
#import "UIViewExt.h"
#define LineColor RGB(197, 197, 198) //线条颜色
@implementation WeiBoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.width = SCREENWIDTH;
   
  
    
    //内容textView
    
    self.contentLabel.right = SCREENWIDTH - 20;
    self.contentLabel.left =  self.nameLabel.left;
    self.contentLabel.width = SCREENWIDTH - 100;
    self.contentLabel.editable = NO;
    self.contentLabel.userInteractionEnabled = NO;
    
    //转发  点赞  发言 位置处理
    self.speakButton.right = self.contentLabel.right;
    self.no3Label.right = self.speakButton.right;
    
    self.goodButton.right = self.speakButton.left - 20;
    self.no1Label.right = self.goodButton.right;
    
    self.relayButton.right = self.goodButton.left - 20;
    self.no0Label.right = self.relayButton.right;
    
    
    //底部处理
    self.bottomLine = [UIView new];
     [self addSubview:self.bottomLine];
    self.bottomLine.height = 2;
    self.bottomLine.left=0;
    self.bottomLine.top = self.bottom-1;   //执行在这里的时候 其实是199
    self.bottomLine.width = self.width;
    self.bottomLine.backgroundColor = LineColor;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
