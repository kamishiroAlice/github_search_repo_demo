//
//  SearchItemViewModel.m
//  github_repo_search
//
//  Created by narcissu on 17/2/16.
//  Copyright © 2017年 sppl. All rights reserved.
//

#import "RepoViewModel.h"
@implementation RepoViewModel
- (instancetype)initWithModel:(NodeModel *)model{
    if (self = [super init]) {
        self.author = model.owner;
        self.name = model.name;
        self.desc = model.desc;
        self.language = model.primaryLanguage;
        self.starCount = [NSString stringWithFormat:@"%ld",model.stargazers];
        self.forkCount = [NSString stringWithFormat:@"%ld",model.forks];
        NSDate *date = [NSDate githubDate:model.createdAt];
        self.time = [date dateDescription];
        self.url = model.url;
    }
    return self;
}
@end
