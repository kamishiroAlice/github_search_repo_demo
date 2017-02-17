//
//  UINavigationController+StatusBar.m
//  github_repo_search
//
//  Created by narcissu on 17/2/17.
//  Copyright © 2017年 sppl. All rights reserved.
//

#import "UINavigationController+StatusBar.h"

@implementation UINavigationController (StatusBar)
- (UIStatusBarStyle)preferredStatusBarStyle{
    return [self.topViewController preferredStatusBarStyle];
}
@end
