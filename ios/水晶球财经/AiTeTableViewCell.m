//
//  AiTeTableViewCell.m
//  水晶球财经
//
//  Created by 罗海方 on 15/11/18.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "AiTeTableViewCell.h"
#import "UIViewExt.h"

@implementation AiTeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.width = SCREENWIDTH;
    self.backgroundColor = RGB(90.59, 102.9, 104.91);
    
   
    
    self.textView0.width = SCREENWIDTH - 66 - 20;
    self.textView0.backgroundColor = RGB(240, 240, 242);
    
    self.backgroundView1.backgroundColor = [UIColor whiteColor];
    
    self.textView1.width = SCREENWIDTH - 66 - 20;
    self.textView1.backgroundColor = RGB(240, 240, 242);
    
    self.replayButton.left = 30;
    self.goodButton.centerX = SCREENWIDTH * 0.5;
    self.commentButton.right = SCREENWIDTH - 30;
    
    UIView* ButtomView = [UIView new];
    ButtomView.width = SCREENWIDTH;
    ButtomView.height = 3;
   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
