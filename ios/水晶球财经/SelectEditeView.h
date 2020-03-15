//
//  SelectEditeView.h
//  水晶球财经
//
//  Created by 罗海方 on 15/11/19.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectEditeViewDelegete<NSObject>
@required
-(void)shortWeiBoBtnAction;  //发表短微博
-(void)longWeiBoBtnAction;  //发表长微博
-(void)leaveBtnAction;   //离开页面
@end



@interface SelectEditeView : UIView

@property(nonatomic,strong)UIButton* longWeiBoBtn;
@property(nonatomic,strong)UIButton* shortWeiBoBtn;
@property(nonatomic,assign)id<SelectEditeViewDelegete> delegete;


@end
