//
//  RecivedCommenCell.m
//  评论demo
//
//  Created by Tom lu on 15/11/13.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "RecivedCommenCell.h"
#import "UIViewExt.h"


@implementation RecivedCommenCell

- (void)awakeFromNib {
    
    self.width = SCREENWIDTH;
    self.imageView0.left = 8;
    self.nameLabel0.left = self.imageView1.right+8;
    self.replyButton.right = self.width - 8;
    self.replyButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.replyButton.layer.borderWidth = 1;
    self.replyButton.layer.cornerRadius = 8;
    
    self.timeLabel0.left = self.nameLabel0.left;
    
    self.textView0.left = self.imageView0.left;
    self.textView0.width = SCREENWIDTH - 16;
    self.textView0.editable = NO;
    
    self.middleLine.left = 0;
    self.middleLine.width = SCREENWIDTH;
    
    self.imageView1.left = 8;
    self.imageView1.backgroundColor = [UIColor redColor];
    self.nameLabel1.left = self.imageView1.right + 8;
    self.textView1.left = self.nameLabel1.left;
    self.textView1.width = SCREENWIDTH - 63 - 8;
    self.textView1.editable = NO;
    self.timeLabel1.left = self.textView1.left;
    
    
    self.bottomLine.width = SCREENWIDTH;
    
    self.textView0.backgroundColor = [UIColor lightGrayColor];
    self.textView1.backgroundColor = [UIColor lightGrayColor];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
