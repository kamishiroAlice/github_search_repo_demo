//
//  github_net+search.h
//  github_repo_search
//
//  Created by narcissu on 17/2/16.
//  Copyright © 2017年 sppl. All rights reserved.
//

#import "github_net.h"
@interface github_net (search)
+ (RACSignal *)searchRepoWithQuery:(NSString *)query first:(NSInteger)first last:(NSInteger)last after:(NSString *)after before:(NSString *)before;
@end
