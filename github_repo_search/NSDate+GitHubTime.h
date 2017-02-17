//
//  NSDate+DGTime.h
//  DGOCM
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (GitHubTime)
+ (NSDate *)githubDate:(NSString *)str;
- (NSString *)dateDescription;
@end
