//
//  SearchItemViewModel.h
//  github_repo_search
//
//  Created by narcissu on 17/2/16.
//  Copyright © 2017年 sppl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NodeModel.h"
@interface RepoViewModel : NSObject
@property(nonatomic,copy)NSString *author;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *language;
@property(nonatomic,copy)NSString *starCount;
@property(nonatomic,copy)NSString *forkCount;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *url;
- (instancetype)initWithModel:(NodeModel *)model;
@end
