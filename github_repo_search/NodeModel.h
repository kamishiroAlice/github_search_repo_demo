//
//  NodeModel.h
//  github_repo_search
//
//  Created by narcissu on 17/2/16.
//  Copyright © 2017年 sppl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NodeModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *primaryLanguage;
@property(nonatomic,copy)NSString *owner;
@property(nonatomic,assign)NSInteger stargazers;
@property(nonatomic,assign)NSInteger forks;
@property(nonatomic,copy)NSString *createdAt;
@end
