//
//  UserInfo.m
//  水晶球财经
//
//  Created by Tom lu on 15/11/4.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

static UserInfo *sharedObj = nil;

+ (UserInfo*) sharedInfo
{
    @synchronized (self)
    {
        if (sharedObj == nil)
        {
            sharedObj = [[self alloc] init];
        }
    }
    return sharedObj;
}

@end
