//
//  UserInfo.h
//  水晶球财经
//
//  Created by Tom lu on 15/11/4.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject


@property(nonatomic,strong)NSString* userName;   // 用户名
@property(nonatomic,strong)NSString* userPwd;  //用户密码
@property(nonatomic,strong)NSString* userId;   //用户ID
@property(nonatomic,strong)NSString* userNick; // 用户昵称

@property(nonatomic,strong)NSString* userImage;   //用户头像url
@property(nonatomic,assign)int userSex;           //用户性别
@property(nonatomic,strong)NSString* userTitle;   //用户头衔
@property(nonatomic,strong)NSString* userDescrib; //用户简介
@property(nonatomic,assign)unsigned userCoin;     //水晶币
@property(nonatomic,assign)unsigned userAttentions; //被关注数
@property(nonatomic,assign)unsigned userFans;       //粉丝数



+ (UserInfo*) sharedInfo;  //返回临时单例用户
@end
