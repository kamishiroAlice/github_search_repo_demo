//
//  ViewController.m
//  github_repo_search
//
//  Created by narcissu on 17/2/16.
//  Copyright © 2017年 sppl. All rights reserved.
//

#import "SearchViewCtrl.h"
#import "SearchMsgView.h"
#import "SearchCtrlViewModel.h"
#import "RepoItemTableViewCell.h"
#import "SearchDetailViewCtrl.h"
#import "ItoalTool.h"

@interface SearchViewCtrl ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (strong, nonatomic) UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet SearchMsgView *searchMsgView;
@property (weak, nonatomic) IBOutlet UITableView *resultView;
@property(nonatomic,strong) SearchCtrlViewModel *viewModel;

@property(nonatomic,strong)RACSignal *searchSignal;
@end

@implementation SearchViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.searchMsgView hidden];
    self.viewModel = [[SearchCtrlViewModel alloc]init];
    [self setNav];
    [self bindViewModel];
}

- (void)bindViewModel{
    @weakify(self);
    RAC(self.searchMsgView.repoLabel,text) = [RACObserve(self.viewModel, repositoryCount) skip:1];
    RAC(self.searchMsgView.codeLabel,text) = [RACObserve(self.viewModel, codeCount) skip:1];
    RAC(self.searchMsgView.preBtn,userInteractionEnabled) = [RACObserve(self.viewModel, hasPreviousPage) skip:1];
    RAC(self.searchMsgView.nextBtn,userInteractionEnabled) = [RACObserve(self.viewModel, hasNextPage) skip:1];
    RAC(self.searchMsgView.pageLabel,text) = [[RACObserve(self, viewModel.page) skip:1] map:^id(NSNumber *value) {
        return [NSString stringWithFormat:@"%@",value];
    }];
    
    RACSignal *repoViewModelsSignal = RACObserve(self.viewModel, repoViewModels);
    [[repoViewModelsSignal skip:1] subscribeNext:^(NSArray *viewModels) {
        @strongify(self);
        [ItoalTool hiddenAllHudsForView:self.view];
        if (viewModels != nil && viewModels.count > 0) {
            [self.searchMsgView show];
        } else {
            [self.searchMsgView hidden];
        }
        [self.resultView reloadData];
    }];
    
    //TODO: EVENT
    self.searchBar.delegate = self;
    self.searchSignal = [self rac_signalForSelector:@selector(searchBar:textDidChange:) fromProtocol:@protocol(UISearchBarDelegate)];
    self.searchSignal = [self.searchSignal throttle:0.3f];
    self.searchSignal = [self.searchSignal flattenMap:^RACStream *(RACTuple *tuple) {
        @strongify(self);
        [self.view endEditing:YES];
        [ItoalTool createMBProgressshowHUDAddedTo:self.view message:LoadingMessage animated:YES];
        
        NSString *text = tuple.second;
        return [self.viewModel search:text];
    }];
    
    [self.searchSignal subscribeNext:^(NSError *x) {
        @strongify(self);
        if ([x isKindOfClass:[NSError class]]) {
            [self dealError];
            return;
        }
        self.viewModel.page = 1;
        NSLog(@"x");
    }];
    
    [self.searchMsgView setPreClick:^{
        @strongify(self);
        [ItoalTool createMBProgressshowHUDAddedTo:self.view message:LoadingMessage animated:YES];
        RACSignal *preSignal = [self.viewModel pre];
        [preSignal subscribeNext:^(id x) {
            @strongify(self);
            if ([x isKindOfClass:[NSError class]]) {
                [self dealError];
                return;
            }
            self.viewModel.page -= 1;
        }];
    }];
    [self.searchMsgView setNextClick:^{
        @strongify(self);
        [ItoalTool createMBProgressshowHUDAddedTo:self.view message:LoadingMessage animated:YES];
        RACSignal *nextSignal = [self.viewModel next];
        [nextSignal subscribeNext:^(id x) {
            @strongify(self);
            if ([x isKindOfClass:[NSError class]]) {
                [self dealError];
                return;
            }
            self.viewModel.page += 1;
        }];
    }];
    
    
}

- (void)dealError{
    [ItoalTool hiddenAllHudsForView:self.view];
    [self.viewModel willChangeValueForKey:@"repoViewModels"];
    self.viewModel.repoViewModels = nil;
    [self.viewModel didChangeValueForKey:@"repoViewModels"];
    [ItoalTool showMessage:LoadingFailMessage inView:self.view];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)setNav{
    [self.navigationController.navigationBar setTranslucent:NO];
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.frame = CGRectMake(0, 0, 250, 44);
    self.navigationItem.titleView = self.searchBar;
    self.navigationController.navigationBar.barTintColor = NAVCOLOR;
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.repoViewModels.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RepoItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RepoItemTableViewCell class])];
    RepoViewModel *viewModel = self.viewModel.repoViewModels[indexPath.row];
    [cell bindViewModel:viewModel];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([RepoItemTableViewCell class]) configuration:^(id cell) {
        RepoItemTableViewCell *mycell = cell;
        RepoViewModel *viewModel = self.viewModel.repoViewModels[indexPath.row];
        [mycell bindViewModel:viewModel];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RepoViewModel *viewModel = self.viewModel.repoViewModels[indexPath.row];
    SearchDetailViewCtrl *vc = [[UIStoryboard storyboardWithName:NSStringFromClass([SearchDetailViewCtrl class])  bundle:nil] instantiateInitialViewController];
    vc.url = viewModel.url;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
