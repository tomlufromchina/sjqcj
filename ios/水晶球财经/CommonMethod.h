//
//  CommonMethod.h
//  水晶球财经
//
//  Created by Tom lu on 15/11/2.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CommonMethod : NSObject

//解析返回的对象，变为字典
+(NSDictionary*)serializdDictionaryWithResponseObject:(id)responseObject;

//主url不变部分
+(NSString*)UrlAddAction:(NSString*)Action ;


//功能：让oldLabel 通过给出的contentStr字符串，动态改变oldLabel的高度  并且返回新高度值
//+ (CGFloat)changeHightForNewLabel:(UILabel*)oldLabel
//                       withString:(NSString*)contentStr;

//功能：通过json中获取到的时间戳，得到时间字符串 "年-月-日 时-分"  方式显示
+ (NSString*)getTimeStrWithTimeStamp:(NSString*)timeStamp;


//功能： 富文本字符串中含有图片， 图片的字符串需要替换处理 用这个方法
+(NSString*)dealImageInHTMLContentString:(NSString*)content;
@end
