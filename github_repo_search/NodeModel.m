//
//  NodeModel.m
//  github_repo_search
//
//  Created by narcissu on 17/2/16.
//  Copyright © 2017年 sppl. All rights reserved.
//

#import "NodeModel.h"

@implementation NodeModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
          @"desc":@"description",
          @"primaryLanguage":@"primaryLanguage.name",
          @"stargazers":@"stargazers.totalCount",
          @"forks":@"forks.totalCount",
          @"owner":@"owner.login"
          };
}
@end
