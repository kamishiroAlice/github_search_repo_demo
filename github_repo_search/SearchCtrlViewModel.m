//
//  SearchCtrlViewModel.m
//  github_repo_search
//
//  Created by narcissu on 17/2/16.
//  Copyright © 2017年 sppl. All rights reserved.
//

#import "SearchCtrlViewModel.h"

@interface SearchCtrlViewModel ()
@property(nonatomic,copy)NSString *lastId;
@property(nonatomic,copy)NSString *firstId;
@property(nonatomic,copy)RACStream*(^parserBlock)(RACTuple *);
@property(nonatomic,copy)NSString *query;
@end

@implementation SearchCtrlViewModel
- (RACSignal *)search:(NSString *)query{
    self.query = query;
    RACSignal *reSignal = [github_net searchRepoWithQuery:query first:10 last:0 after:nil before:nil];
    return [reSignal flattenMap:self.parserBlock];
}

- (RACSignal *)next{
    RACSignal *reSignal = [github_net searchRepoWithQuery:self.query first:10 last:0 after:self.model.pageInfo.endCursor before:nil];
    reSignal = [reSignal flattenMap:self.parserBlock];
    return reSignal;
    
//    [reSignal subscribeNext:^(id x) {
//        @strongify(self);
//        self.page += 1;
//    }];
}

- (RACSignal *)pre{
    RACSignal *reSignal = [github_net searchRepoWithQuery:self.query first:0 last:10 after:nil before:self.model.pageInfo.startCursor];
    reSignal = [reSignal flattenMap:self.parserBlock];
    return reSignal;
//    @weakify(self);

}

- (instancetype)init{
    if (self = [super init]) {
        @weakify(self);
        RACStream* (^parserBlock)(RACTuple *) = ^(RACTuple *tuple)  {
            @strongify(self);
            //记录id
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                if ([tuple isKindOfClass:[NSError class]]) {
                    [subscriber sendNext:tuple];
                    return nil;
                }
                
                NSDictionary *result = tuple.first;
                NSDictionary *data = [result dictionaryValueForKeyPath:DATAKEY];
                NSDictionary *search = [data dictionaryValueForKeyPath:SEARCHKEY];
                
                ReposSetModel *model = [ReposSetModel mj_objectWithKeyValues:search];
                NSMutableArray *repoViewModels = [[NSMutableArray alloc]init];
                [model.nodes enumerateObjectsUsingBlock:^(NodeModel *node, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([node isKindOfClass:[NodeModel class]]) {
                        [repoViewModels addObject:[[RepoViewModel alloc]initWithModel:node]];
                    }
                }];
                
                self.repoViewModels = repoViewModels;
                self.repositoryCount = [NSString stringWithFormat:@"%ld",model.repositoryCount];
                self.codeCount = [NSString stringWithFormat:@"%ld",model.codeCount];;
                self.hasNextPage = model.pageInfo.hasNextPage;
                self.hasPreviousPage = model.pageInfo.hasPreviousPage;
                self.model = model;
                
                [subscriber sendNext:nil];
                //            [subscriber sendCompleted];
                return nil;
            }];
        };
        self.parserBlock = parserBlock;
        
    }
    return self;
}


@end
