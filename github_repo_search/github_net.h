//
//  github_net.h
//  github_repo_search
//
//  Created by narcissu on 17/2/16.
//  Copyright © 2017年 sppl. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DATAKEY @"data"
#define SEARCHKEY @"search"

@interface github_net : NSObject
+ (RACSignal *)githubGraphQL:(NSString *)ql;
@end
