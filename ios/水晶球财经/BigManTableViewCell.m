//
//  BigManTableViewCell.m
//  Crystal
//
//  Created by Tom lu on 15/10/27.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "BigManTableViewCell.h"
#import "UIViewExt.h"
@implementation BigManTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.width = SCREENWIDTH;
    self.addButton.right = self.width - 20;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
