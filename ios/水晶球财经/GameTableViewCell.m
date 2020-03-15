//
//  GameTableViewCell.m
//  水晶球财经
//
//  Created by 罗海方 on 15/11/23.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "GameTableViewCell.h"
#import "UIViewExt.h"
@implementation GameTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //处理宽度
    self.width = SCREENWIDTH;
    
    self.constLabel0.right = self.width - 10;
    self.weekScoreLabel.right = self.constLabel0.left - 10;
    
    self.constLabel1.right = self.width - 10;
    self.allScoreLabel.right = self.constLabel1.left - 10;
    
    self.middleLineView.width = self.width - 16;
    self.middleLineView.right = self.width - 8;
    
    self.constLabel2.left = 40;
    self.constLabel3.centerX = self.width * 0.5;
    self.constLabel4.right = self.width - 40;
    
    self.stockNameLabel.centerX = self.constLabel2.centerX;
    self.newestPricesLabel.centerX = self.constLabel3.centerX;
    self.updownLabel.centerX = self.constLabel4.centerX;
    
    self.stockNameLabel1.centerX = self.constLabel2.centerX;
    self.newestPricesLabel1.centerX = self.constLabel3.centerX;
    self.updownLabel1.centerX = self.constLabel4.centerX;

    
    //处理buttomLine
    UIView* buttomLine = [UIView new];
    [self addSubview:buttomLine];
    buttomLine.width = SCREENWIDTH;
    buttomLine.height = 3;
    buttomLine.left = 0;
    buttomLine.top = self.height -2;
    buttomLine.backgroundColor = [UIColor grayColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
