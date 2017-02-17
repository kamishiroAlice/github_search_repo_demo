//
//  ItoalTool.h
//  MMCommonChanel
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LoadingMessage @"正在加载"
#define LoadingFailMessage @"没有加载到数据"
NS_ASSUME_NONNULL_BEGIN
@interface ItoalTool : NSObject
+ (id)createMBProgressshowHUDAddedTo:(UIView *)view message:(NSString *)message animated:(BOOL)animated;

+ (id)createMBProgressshowHUDAddedTo:(UIView *)view title:(NSString *)title detialText:(NSString *)detialText animated:(BOOL)animated;

+ (void)showMessage:(NSString * __nonnull)message inView:(UIView * __nonnull)view;

+ (void)hiddenAllHudsForView:(UIView *)view;

@end
NS_ASSUME_NONNULL_END
