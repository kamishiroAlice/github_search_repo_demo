//
//  ReposSetModel.m
//  github_repo_search
//
//  Created by narcissu on 17/2/16.
//  Copyright © 2017年 sppl. All rights reserved.
//

#import "ReposSetModel.h"

@implementation ReposSetModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"nodes" : @"NodeModel"
             };
}
@end
