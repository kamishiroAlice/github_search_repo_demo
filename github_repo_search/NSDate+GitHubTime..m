//
//  NSDate+DGTime.m
//  DGOCM
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSDate+GitHubTime.h"

@implementation NSDate (GitHubTime)

+ (NSDate *)githubDate:(NSString *)str{
    if ([str containsString:@"T"] && [str containsString:@"Z"]) {
        NSString *subStr = [str stringByReplacingOccurrencesOfString:@"T" withString:@""];
        subStr = [subStr stringByReplacingOccurrencesOfString:@"Z" withString:@""];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"YYYY-MM-ddHH:mm:ss";
        formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
        return [formatter dateFromString:subStr];

    } else{
        return nil;
    }
}

- (NSString *)dateDescription{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    if ([calendar isDateInToday:self]) {
        NSTimeInterval delta = [[[NSDate alloc]init] timeIntervalSinceDate:self];
        if (delta < 60) {
            return @"刚刚";
        }
        
        if (delta < 3600) {
            return [NSString stringWithFormat:@"%d分钟前",(int)delta / 60];
        }
        return [NSString stringWithFormat:@"%d小时前",(int)delta / 3600];
        // @"\(delta / 3600)小时前";
        
    }
    
    NSString *fmr = @"HH:mm";
    
    if ([calendar isDateInYesterday:self]) {
        fmr = [NSString stringWithFormat:@"昨天 %@",fmr] ;
    }else{
        fmr = [NSString stringWithFormat:@"MM-dd %@",fmr] ;
        NSDateComponents *coms = [calendar components:NSCalendarUnitYear fromDate:self toDate:[[NSDate alloc]init] options:NSCalendarWrapComponents];
        if (coms.year != 0) {
            fmr = [NSString stringWithFormat:@"yyyy-%@",fmr] ;
        }
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = fmr;
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    return [formatter stringFromDate:self];
}
@end
