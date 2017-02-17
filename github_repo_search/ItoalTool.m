//
//  ItoalTool.m
//  MMCommonChanel
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ItoalTool.h"
#import <MBProgressHUD/MBProgressHUD.h>
@implementation ItoalTool
+ (id)createMBProgressshowHUDAddedTo:(UIView *)view message:(NSString *)message animated:(BOOL)animated
{
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [hub bringSubviewToFront:view];
    hub.color = [UIColor blackColor];
    hub.alpha = 1;
    if (message.length >0 )
    {
        hub.labelText = message;
    }
    return hub;
}

+ (id)createMBProgressshowHUDAddedTo:(UIView *)view title:(NSString *)title detialText:(NSString *)detialText animated:(BOOL)animated
{
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [hub bringSubviewToFront:view];
    hub.color = [UIColor blackColor];
    hub.alpha = 1;
    if (title.length >0 )
    {
        hub.labelText = title;
    }
    if (detialText.length >0)
    {
        hub.detailsLabelText = detialText;
    }
    return hub;
}

+ (void)showMessage:(NSString * __nonnull)message inView:(UIView * __nonnull)view{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.mode = MBProgressHUDModeText;
    hub.labelText = message;
    [hub hide:YES afterDelay:1.0f];
}

+ (void)hiddenAllHudsForView:(UIView *)view{
    [MBProgressHUD hideAllHUDsForView :view animated:YES];
}
@end
