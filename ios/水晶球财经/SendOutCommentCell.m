//
//  SendOutCommentCell.m
//  水晶球财经
//
//  Created by Tom lu on 15/11/13.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "SendOutCommentCell.h"
#import "UIViewExt.h"
@implementation SendOutCommentCell

- (void)awakeFromNib {
    self.imageView0.left = self.imageView0.top = 8;
    self.nameLabel0.left = 63;
    self.timeLabel0.left = self.nameLabel0.left;
    self.textView0.left = self.imageView0.left;
    self.textView0.backgroundColor = [UIColor lightGrayColor];
    self.textView0.editable = NO;
    self.textView0.width = SCREENWIDTH - 16;
    
    self.middleLine.left = 0;
    self.middleLine.width = SCREENWIDTH;
    
    self.imageView1.left = 8;
    self.nameLabel1.left = 63;
    self.textView1.left = self.nameLabel1.left;
    self.textView1.width = SCREENWIDTH - 63 - 8;
    self.textView1.editable = NO;
    self.textView1.backgroundColor = [UIColor lightGrayColor];
    self.timeLabel1.left = self.textView1.left;
    
    self.bottomLine.left = 0;
    self.bottomLine.width = SCREENWIDTH;
    self.bottomLine.top = 250-5;
    self.bottomLine.height = 5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
