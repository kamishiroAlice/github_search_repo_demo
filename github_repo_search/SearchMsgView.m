//
//  SearchMsgView.m
//  github_repo_search
//
//  Created by narcissu on 17/2/16.
//  Copyright © 2017年 sppl. All rights reserved.
//

#import "SearchMsgView.h"

static UIImage *_repoIcon = nil;
static UIImage *_codeIcon = nil;

static NSInteger height = 80;

@interface SearchMsgView()


@property (weak, nonatomic) IBOutlet UIImageView *repoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;

@property(nonatomic,weak) IBOutlet NSLayoutConstraint *lineHeight;
@property(nonatomic,weak) IBOutlet NSLayoutConstraint *heightLayout;
@end

@implementation SearchMsgView

- (void)awakeFromNib{
    @weakify(self);
    self.lineHeight.constant = 0.5;
//
    [self.repoImageView setImage:[UIImage octicon_imageWithIdentifier:@"Repo" size:self.repoImageView.frame.size]];
    [self.codeImageView setImage:[UIImage octicon_imageWithIdentifier:@"FileCode" size:self.codeImageView.frame.size]];
    
    [[self.preBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
         @strongify(self);
        self.preClick();
    }];
    
    [[self.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        self.nextClick();
    }];
    
    RACSignal *preColorSignal = [RACObserve(self.preBtn, userInteractionEnabled) map:^id(NSNumber *value) {
        return [value boolValue] ? [UIColor blueColor] : [UIColor lightGrayColor];
    }];
    
    RACSignal *nextColorSignal = [RACObserve(self.nextBtn, userInteractionEnabled) map:^id(NSNumber *value) {
        return [value boolValue] ? [UIColor blueColor] : [UIColor lightGrayColor];
    }];
    
    [self.preBtn rac_liftSelector:@selector(setTitleColor:forState:) withSignals:preColorSignal,[RACSignal return:@(UIControlStateNormal)], nil];
    
    [self.nextBtn rac_liftSelector:@selector(setTitleColor:forState:) withSignals:nextColorSignal,[RACSignal return:@(UIControlStateNormal)], nil];
}

- (void)hidden{
    self.heightLayout.constant = 0;
}

- (void)show{
    self.heightLayout.constant = height;
}

- (void)changeButton:(ButtonType)type avaliable:(BOOL)avaliable{
    UIButton *btn = nil;
    if (type == preButton) {
        btn = self.preBtn;
    }else{
        btn = self.nextBtn;
    }
    
    btn.userInteractionEnabled = avaliable;
    UIColor *btnColor = avaliable ? [UIColor blueColor] : [UIColor lightGrayColor];
    [btn setTitleColor:btnColor forState:UIControlStateNormal];
}

@end
