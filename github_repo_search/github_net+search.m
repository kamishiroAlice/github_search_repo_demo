//
//  github_net+search.m
//  github_repo_search
//
//  Created by narcissu on 17/2/16.
//  Copyright © 2017年 sppl. All rights reserved.
//

#import "github_net+search.h"

@implementation github_net (search)
+ (RACSignal *)searchRepoWithQuery:(NSString *)query first:(NSInteger)first last:(NSInteger)last after:(NSString *)after before:(NSString *)before{
    NSMutableString *ql = [[NSMutableString alloc]init];
    [ql appendString:@"{"];
    [ql appendString:[NSString stringWithFormat:@"search(query:\"%@\",type:REPOSITORY",query]];
    if (first > 0) {
        [ql appendString:@",first:"];
        [ql appendString:
                        [NSString stringWithFormat:@"%ld",first]];
    }
    
    if (last > 0) {
        [ql appendString:@",last:"];
        [ql appendString:
         [NSString stringWithFormat:@"%ld",last]];
    }
    
    if (after.length > 0) {
        [ql appendString:@"after:\""];
        [ql appendString:after];
        [ql appendString:@"\""];
    }
    
    if (before.length > 0) {
        [ql appendString:@"before:\""];
        [ql appendString:before];
        [ql appendString:@"\""];
    }
    
    [ql appendString:@"){ \
     repositoryCount, \
     codeCount, \
     nodes{\
     ... on Repository{\
         name,\
         url,\
         description,\
         createdAt,\
         owner{\
             login\
         }\
         descriptionHTML,\
         diskUsage,\
         path,\
         primaryLanguage{\
             name\
         },\
         stargazers{\
             totalCount\
         },\
         forks{\
             totalCount\
         }\
     } \
     },\
     pageInfo { \
         endCursor \
         hasNextPage \
         hasPreviousPage \
         startCursor \
     } \
     } \
     }"];
    
    return [self githubGraphQL:ql];
}
@end
