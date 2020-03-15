//
//  UILabel+StringFrame.h
//  JiheQuan
//
//  Created by 0001 on 15/6/24.
//  Copyright (c) 2015年 WJ. All rights reserved.
// 根据字体 获取到新的Size  如果宽度固定 高度变化：｛xxx，MAXFLOAT｝ 

#import <UIKit/UIKit.h>

@interface UILabel (StringFrame)

- (CGSize)boundingRectWithSize:(CGSize)size;

@end
