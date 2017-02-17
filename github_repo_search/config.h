//
//  config.h
//  github_repo_search
//
//  Created by narcissu on 17/2/16.
//  Copyright © 2017年 sppl. All rights reserved.
//

#ifndef config_h
#define config_h
#import <Foundation/Foundation.h>
#import "RACAFNetworking.h"
#import "XMLDictionary.h"
#import "github_net.h"
#import "github_net+search.h"
#import "UIImage+MRCOcticons.h"
#import <MJExtension/MJExtension.h>
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import "NSDate+GitHubTime.h"
#import "UINavigationController+StatusBar.h"
#import "ItoalTool.h"

#define GITHUBTokenKey @"Authorization"
#define GITHUBToken @"Bearer de5288c34e2562f0581c93cf5bde730f3ec82f8f"
#define GITHUBAPIURL @"https://api.github.com/graphql"

#define IOS_8Under ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)

#define NAVCOLOR [UIColor colorWithRed:33 / 255.0F green:50 / 255.0F blue:59 / 255.0F alpha:1]

//NSString const *GITHUBTokenKey = @"Authorization";
//NSString const *GITHUBToken =

#endif /* config_h */
