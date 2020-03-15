//
//  BaseViewController.h
//  水晶球财经
//
//  Created by Tom lu on 15/10/28.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

//加载动画  不会释放
- (void)show;

//加载动画+图片  不会释放
- (void)showImage:(UIImage *)image status:(NSString *)string;


//显示成功  显示完 释放
-(void)showSuccess;

//显示失败   显示玩 释放
-(void)showError;


//取消单例
- (void)dismiss;



//alert提示框  不能封装在父类中  只能在子类中申明使用
//-(void)showAlert:(NSString*)title  message:(NSString*)message;
@end
