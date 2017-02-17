//
//  PageInfoModel.h
//  github_repo_search
//
//  Created by narcissu on 17/2/16.
//  Copyright © 2017年 sppl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageInfoModel : NSObject
@property(nonatomic,assign)BOOL hasNextPage;
@property(nonatomic,assign)BOOL hasPreviousPage;
@property(nonatomic,copy)NSString *endCursor;
@property(nonatomic,copy)NSString *startCursor;
@end
