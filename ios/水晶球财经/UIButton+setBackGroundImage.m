//
//  UIButton+setBackGroundImage.m
//  水晶球财经
//
//  Created by Tom lu on 15/11/1.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "UIButton+setBackGroundImage.h"

@implementation UIButton (setBackGroundImage)


- (void)setBackgroundImage:(UIImage*)image
{
    CGRect rect;
    rect = self.frame;
    rect.size = image.size; // set button size as image size
    self.frame = rect;
    
    [self setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)setBackgroundImageByName:(NSString*)imageName
{
    [self setBackgroundImage:[UIImage imageNamed:imageName]];
}

@end
