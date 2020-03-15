//
//  CommonMethod.m
//  水晶球财经
//
//  Created by Tom lu on 15/11/2.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "CommonMethod.h"

@implementation CommonMethod

//创建url包含随机数
+(NSString*)UrlAddAction:(NSString*)Action //增加动作（） 。默认处理，后面还要加上随机数
               
{
    NSString* addActionString;
    if(Action==nil || Action.length==0){
        perror("没有传入参数");
    }else{
        addActionString = [MainUrl stringByAppendingString:Action];
    }
    
    //系统的时间戳 1
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    long b = [NSNumber numberWithFloat:a].longValue;
    NSString *safePart2 = [NSString stringWithFormat:@"%lu", b]; //第二部分 时间戳
    //6位随机字符串 2
    int randomNumber = [CommonMethod getRandomNumber:100000 to:999999];
    NSString* safePaer3 = [NSString stringWithFormat:@"%d",randomNumber];//第三部分 随机数
    
    
    
    //整合 数组+时间戳+随机数
    NSString* urlSuf  = [NSString stringWithFormat:@"&sjc=%d%@%@",1,safePart2,safePaer3];
    
    //整合url
    NSString* url = [addActionString stringByAppendingString:urlSuf]; //完整url
    return url;

}



//解析返回后的responseObject 对象 返回新字典
+(NSDictionary*)serializdDictionaryWithResponseObject:(id)responseObject
{
    NSString *jsonString=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(!err){
        return jsonDic;
    }else{
        NSLog(@"json解析错误%@\n",err);
        return nil;
    }
}


+(int)getRandomNumber:(int)from to:(int)to    //[ )

{
    return (int)(from + (arc4random() % (to - from + 1)));
}


+(NSString*)getTimeStrWithTimeStamp:(NSString*)timeStamp
{
    //处理创建时间
    NSTimeInterval time=[timeStamp doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

//处理富文本字符串中间的图片问题
+(NSString*)dealImageInHTMLContentString:(NSString*)content
{
    NSString* html_str = content;
    NSString* oldPartStr = @"__THEME__";
    NSString* newPartStr = @"http://www.sjqcj.com/addons/theme/stv1/_static";
    NSString* newHtmlStr = [html_str stringByReplacingOccurrencesOfString:oldPartStr withString:newPartStr];
    return newHtmlStr;
}
@end
