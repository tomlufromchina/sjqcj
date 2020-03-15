//
//  SEViewController.h
//  水晶球财经
//
//  Created by 罗海方 on 15/11/24.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "BaseViewController.h"
#import <UIKit/UIKit.h>

enum EditeStyle{
    EditeStyleLongWeiBo = 0,  //编辑长微博
    EditeStyleShortWeiBo ,    //编辑短微博
    EditeStyleComment,        //编辑评论
    EditeStyleReply,          //回复被人的帖子
};


@interface SEViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *textfeild;

/////////////////////需要传递过来的属性
@property(nonatomic,assign) enum EditeStyle editeStyle; //编辑类型

@end
