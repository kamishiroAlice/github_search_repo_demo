//
//  RepoItemTableViewCell.m
//  github_repo_search
//
//  Created by narcissu on 17/2/16.
//  Copyright © 2017年 sppl. All rights reserved.
//

#import "RepoItemTableViewCell.h"


static UIImage *_repoIcon = nil;
static UIImage *_repoForkedIcon = nil;
static UIImage *_starIcon = nil;

@interface RepoItemTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *repoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *starImageView;
@property (weak, nonatomic) IBOutlet UIImageView *forkImageView;
@end

@implementation RepoItemTableViewCell

- (void)awakeFromNib {
    self.descLabel.numberOfLines = 0;
    _repoIcon = [UIImage octicon_imageWithIdentifier:@"Repo" size:self.repoImageView.frame.size];
    _repoForkedIcon = [UIImage octicon_imageWithIdentifier:@"RepoForked" size:self.forkImageView.frame.size];
    _starIcon = [UIImage octicon_imageWithIdentifier:@"Star" size:self.starImageView.frame.size];
    
    self.repoImageView.image = _repoIcon;
    self.starImageView.image = _starIcon;
    self.forkImageView.image = _repoForkedIcon;
    // Initialization code
}

- (void)bindViewModel:(RepoViewModel *)viewModel{
    self.authorLabel.text = viewModel.author;
    self.repoNameLabel.text = viewModel.name;
    self.descLabel.text = viewModel.desc;
    self.typeLabel.text = viewModel.language.length > 0 ? viewModel.language : @"unknow";
    self.starLabel.text = viewModel.starCount;
    self.forkLabel.text = viewModel.forkCount;
    self.timeLabel.text = viewModel.time;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (IOS_8Under) {
        self.descLabel.preferredMaxLayoutWidth = self.descLabel.bounds.size.width;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
