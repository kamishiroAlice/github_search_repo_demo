//
//  ReposSetModel.h
//  github_repo_search
//
//  Created by narcissu on 17/2/16.
//  Copyright © 2017年 sppl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageInfoModel.h"
#import "NodeModel.h"
@interface ReposSetModel : NSObject
@property(nonatomic,assign)NSInteger repositoryCount;
@property(nonatomic,assign)NSInteger codeCount;

@property(nonatomic,strong)NSArray *nodes;
@property(nonatomic,strong)PageInfoModel *pageInfo;


@end
