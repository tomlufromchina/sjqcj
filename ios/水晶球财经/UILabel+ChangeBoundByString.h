//
//  UILabel+ChangeBoundByString.h
//  水晶球财经
//
//  Created by Tom lu on 15/10/28.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ChangeBoundByString)


//wid 传入希望固定的宽度  lines 传入0  使用这个方法 必须把之前的label 移除
+ (UILabel*)linesText:(NSString*)text font:(UIFont*)font wid:(CGFloat)wid lines:(int)lines color:(UIColor*)color;

@end
