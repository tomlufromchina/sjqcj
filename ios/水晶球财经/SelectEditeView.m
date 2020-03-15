//
//  SelectEditeView.m
//  水晶球财经
//
//  Created by 罗海方 on 15/11/19.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "SelectEditeView.h"
#import "UIViewExt.h"

@implementation SelectEditeView

-(id)init
{
    if(self = [super init])
    {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    self.width = SCREENWIDTH;
    self.height = SCREENHEIGHT;
    self.backgroundColor = [UIColor whiteColor];
    
    [self createBtnWithAnimation];
    
}

-(void)createBtnWithAnimation
{
    UIButton* shortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shortBtn.width = shortBtn.height = 60;
    [self addSubview:shortBtn];
    shortBtn.centerY = SCREENHEIGHT * 0.5 - 100;
    shortBtn.left = -60;
    [shortBtn setBackgroundImage:[UIImage imageNamed:@"发短微博"] forState:UIControlStateNormal];
    [shortBtn addTarget:self action:@selector(button0Action) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* const0Label = [UILabel new];
    [self addSubview:const0Label];
    const0Label.width = 100;
    const0Label.height = 10;
    const0Label.top = shortBtn.bottom+10;
    const0Label.centerX = shortBtn.centerX;
    const0Label.text = @"编辑短微博";
    const0Label.textAlignment = NSTextAlignmentCenter;
    const0Label.font = [UIFont systemFontOfSize:12];
    
    UIButton* longBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    longBtn.width = longBtn.height = 60;
    [self addSubview:longBtn];
    longBtn.left = SCREENWIDTH;
    longBtn.centerY = shortBtn.centerY ;
     [longBtn setBackgroundImage:[UIImage imageNamed:@"发长微博"] forState:UIControlStateNormal];
    [longBtn addTarget:self action:@selector(botton1Action) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* const1Label = [UILabel new];
    [self addSubview:const1Label];
    const1Label.width = 100;
    const1Label.height = 10;
    const1Label.top = longBtn.bottom + 10;
    const1Label.centerX = longBtn.centerX;
    const1Label.text = @"编辑长微博";
    const1Label.textAlignment = NSTextAlignmentCenter;
    const1Label.font = [UIFont systemFontOfSize:12];
    
    
    //取消按钮
    UIButton* leaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:leaveButton];
    leaveButton.width = SCREENWIDTH - 30; //左右各留15
    leaveButton.height = 40;
    leaveButton.backgroundColor = [UIColor grayColor];
    leaveButton.left = 15;
    [leaveButton setTitle:@"取消" forState:UIControlStateNormal];
    leaveButton.top = const1Label.bottom + 100;
    [leaveButton addTarget:self action:@selector(leaveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView animateWithDuration:0.2 animations:^{
        shortBtn.centerX = SCREENWIDTH* 0.5 - 60;
        longBtn.centerX = SCREENWIDTH* 0.5 + 60;
        const0Label.centerX = shortBtn.centerX;
        const1Label.centerX = longBtn.centerX;
    }];
    
}


/*
 -(void)shortWeiBoBtnAction;  //发表短微博
 -(void)longWeiBoBtnAction;  //发表长微博
 */

#pragma makr -- 离开按钮响应
-(void)leaveButtonAction:(id)sender
{
    if(self.delegete && [self.delegete respondsToSelector:@selector(leaveBtnAction)])
    {
        [self.delegete leaveBtnAction];
    }
}

-(void)button0Action
{
    if(self.delegete && [self.delegete respondsToSelector:@selector(shortWeiBoBtnAction)])
    {
        [self.delegete shortWeiBoBtnAction];
    }
}

-(void)botton1Action
{
    if(self.delegete && [self.delegete respondsToSelector:@selector(longWeiBoBtnAction)])
    {
        [self.delegete longWeiBoBtnAction];
    }

}

@end
