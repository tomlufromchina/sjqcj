//
//  UIImage+scaleSize.m
//  水晶球财经
//
//  Created by 罗海方 on 15/11/19.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "UIImage+scaleSize.h"

@implementation UIImage (scaleSize)


+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize,
                                           image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0,
                                 image.size.width * scaleSize,
                                 image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


+(UIImage*)scaleImage:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    [image drawInRect:CGRectMake(0, 0,size.width,size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
