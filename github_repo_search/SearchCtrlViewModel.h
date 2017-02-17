//
//  SearchCtrlViewModel.h
//  github_repo_search
//
//  Created by narcissu on 17/2/16.
//  Copyright © 2017年 sppl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReposSetModel.h"
#import "RepoViewModel.h"
@interface SearchCtrlViewModel : NSObject

- (RACSignal *)search:(NSString *)query;
- (RACSignal *)next;
- (RACSignal *)pre;
@property(nonatomic,strong)NSArray *repoViewModels;
@property(nonatomic,strong)ReposSetModel *model;


@property(nonatomic,copy)NSString *repositoryCount;
@property(nonatomic,copy)NSString *codeCount;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)BOOL hasNextPage;
@property(nonatomic,assign)BOOL hasPreviousPage;

@end
