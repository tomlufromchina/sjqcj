//
//  UILabel+ChangeBoundByString.m
//  水晶球财经
//
//  Created by Tom lu on 15/10/28.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "UILabel+ChangeBoundByString.h"

@implementation UILabel (ChangeBoundByString)

+ (UILabel*)linesText:(NSString*)text font:(UIFont*)font wid:(CGFloat)wid lines:(int)lines color:(UIColor*)color {
    CGFloat maxH = 0;
    if (lines > 0) {
        maxH = (font.pointSize + 2) * lines + 3;
    } else {
        maxH = 6000;
    }
    CGSize size = CGSizeMake(wid, maxH);
    
    NSMutableParagraphStyle * paragraph = [NSMutableParagraphStyle new];
    paragraph.alignment = NSTextAlignmentLeft;
    if (lines == 1) {
        paragraph.lineBreakMode = NSLineBreakByTruncatingTail;
    } else {
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    }
    NSDictionary * attr = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraph};
    size = [text length] > 0 ? [text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:attr context:nil].size : CGSizeZero;
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    lab.numberOfLines = lines;
    lab.backgroundColor = [UIColor clearColor];
    lab.lineBreakMode = NSLineBreakByTruncatingTail;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.textColor = color;
    lab.font = font;
    lab.text = text;
    //    lab.highlightedTextColor = [UIColor whiteColor];
    return lab;
}


@end
