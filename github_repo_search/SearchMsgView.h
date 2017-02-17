//
//  SearchMsgView.h
//  github_repo_search
//
//  Created by narcissu on 17/2/16.
//  Copyright © 2017年 sppl. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    preButton,
    nextButton
}ButtonType;

@interface SearchMsgView : UIView


@property (weak, nonatomic) IBOutlet UILabel *repoLabel;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;

@property (weak, nonatomic) IBOutlet UILabel *pageLabel;

@property (weak, nonatomic) IBOutlet UIButton *preBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property(nonatomic,copy)void (^preClick)();
@property(nonatomic,copy)void (^nextClick)();

- (void)hidden;
- (void)show;
- (void)changeButton:(ButtonType)type avaliable:(BOOL)avaliable;
@end
