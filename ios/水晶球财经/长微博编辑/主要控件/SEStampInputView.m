//
//  SEStampInputView.m
//  RichTextEditor
//
//  Created by kishikawa katsumi on 13/09/26.
//  Copyright (c) 2013 kishikawa katsumi. All rights reserved.
//

#import "SEStampInputView.h"
#import "UIViewExt.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width

@implementation SEStampInputView

-(void)awakeFromNib
{
    
    self.width = WIDTH;
    self.scrollView.width = self.width;
    self.scrollView.height = self.height;
    self.scrollView.top = 0;
    self.scrollView.left = 0;
    self.scrollView.contentSize = CGSizeMake(WIDTH*4, self.height);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = YES;
    
    self.view0.left = WIDTH*0;
    self.view1.left = WIDTH*1;
    self.view2.left = WIDTH*2;
    self.view3.left = WIDTH*3;
}
@end
