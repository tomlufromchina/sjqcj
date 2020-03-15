//
//  NicePostTableViewCell.m
//  Crystal
//
//  Created by Tom lu on 15/10/27.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "NicePostTableViewCell.h"
#import "UIViewExt.h"
@implementation NicePostTableViewCell




- (void)awakeFromNib {
    // Initialization code
    //这里重新设置一下各个元素位置
    self.width =SCREENWIDTH;
    
    self.titleLabel.width = self.width - self.titleLabel.left - 20;
    self.commentCountLabel.right = self.width - 20;
    self.commentImageView.right = self.commentCountLabel.left;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
