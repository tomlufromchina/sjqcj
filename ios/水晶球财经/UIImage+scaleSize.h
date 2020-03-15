//
//  UIImage+scaleSize.h
//  水晶球财经
//
//  Created by 罗海方 on 15/11/19.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (scaleSize)

//改变图片大小的倍数
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;


//改变图片的宽高
+(UIImage*)scaleImage:(UIImage *)image toSize:(CGSize)size;
@end
