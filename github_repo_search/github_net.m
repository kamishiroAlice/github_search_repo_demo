//
//  github_net.m
//  github_repo_search
//
//  Created by narcissu on 17/2/16.
//  Copyright © 2017年 sppl. All rights reserved.
//

#import "github_net.h"

@implementation github_net
+ (RACSignal *)githubGraphQL:(NSString *)ql{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]
                                              initWithBaseURL:[NSURL URLWithString:GITHUBAPIURL]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return [[manager rac_POST:GITHUBAPIURL parameters:@{@"query":ql}] catch:^RACSignal *(NSError *error) {
        return [RACSignal return:error];
    }];
}
@end
