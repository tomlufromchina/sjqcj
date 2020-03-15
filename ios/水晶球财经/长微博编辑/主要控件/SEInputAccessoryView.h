//
//  SEInputAccessoryView.h
//  RichTextEditor
//
//  Created by kishikawa katsumi on 13/09/26.
//  Copyright (c) 2013 kishikawa katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SEInputAccessoryView : UIToolbar

@property (nonatomic, weak) IBOutlet UIBarButtonItem *keyboardButton; //键盘
@property (nonatomic, weak) IBOutlet UIBarButtonItem *stampButton;    //笑脸
@property (nonatomic, weak) IBOutlet UIBarButtonItem *photoButton;    //图片
@property (nonatomic, weak) IBOutlet UIBarButtonItem *smallerButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *largerButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *colorButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *nomalButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *boldButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *italicButton;

@end
