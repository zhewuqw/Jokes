//
//  ZWRecommendViewController.m
//  Jokes
//
//  Created by zhe wu on 9/30/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "ZWRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "ZWRecommonedCategoryCell.h"
#import <MJExtension.h>
#import "ZWRecommendCategory.h"
#import "ZWRecommendUserCell.h"
#import "ZWRecommendUser.h"
#import <MJRefresh.h>

#define ZWSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]


@interface ZWRecommendViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/** common */
@property (nonatomic, strong) NSArray *categories;

/** common */
@property (nonatomic, strong) NSMutableDictionary *params;

/** common */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation ZWRecommendViewController

static NSString * const ZWCategoryID = @"category";
static NSString * const ZWUserID = @"user";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRefresh];
    
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZWRecommonedCategoryCell class]) bundle:nil] forCellReuseIdentifier:ZWCategoryID];
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZWRecommedUserCell class]) bundle:nil] forCellReuseIdentifier:ZWUserID];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    self.title = @"Suggest";
    self.view.backgroundColor = ZWGlobalBG;
    
    [self loadCategories];
}

- (void)loadCategories
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        self.categories = [ZWRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.userTableView.mj_header beginRefreshing];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"error"];
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) return self.categories.count;
    
    [self checkFootStatus];
    return [ZWSelectedCategory users].count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        ZWRecommonedCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ZWCategoryID];
        cell.categoryList = self.categories[indexPath.row];
        
        return cell;
    } else {
        ZWRecommedUserCell *cell = [tableView dequeueReusableCellWithIdentifier:ZWUserID];
        cell.user = [ZWSelectedCategory users][indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    ZWRecommendCategory *cell = self.categories[indexPath.row];
    
    [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    
    if (cell.users.count) {
        [self.userTableView reloadData];
    } else {
        [self.userTableView reloadData];
        [self.userTableView.mj_header beginRefreshing];
    }
    
}

- (void)checkFootStatus
{
    ZWRecommendCategory *rc = ZWSelectedCategory;
     self.userTableView.mj_footer.hidden = (rc.users.count == 0);
    
    if (rc.users.count == rc.total) {
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        [self.userTableView.mj_footer endRefreshing];
    }
}


- (void)setupRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
}

- (void)loadNewUsers
{
    ZWRecommendCategory *rc = ZWSelectedCategory;
    
    rc.current_page = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.ID);
    params[@"page"] = @(rc.current_page);
    
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        NSArray *users = [ZWRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [rc.users removeAllObjects];
        [rc.users addObjectsFromArray:users];
        
        rc.total = [responseObject[@"total"] integerValue];
        
        if (self.params != params) return;
        
        [self.userTableView reloadData];
        
        [self.userTableView.mj_header endRefreshing];
        
        [self checkFootStatus];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return;
        [SVProgressHUD showErrorWithStatus:@"error"];
        [self.userTableView.mj_header endRefreshing];
    }];
    
}

- (void)loadMoreUsers
{
    ZWRecommendCategory *category = ZWSelectedCategory;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.ID);
    params[@"page"] = @(++category.current_page);
    self.params = params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
    
        NSArray *users = [ZWRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [category.users addObjectsFromArray:users];
        
        if (self.params != params) return;
        
        [self.userTableView reloadData];
        
        [self checkFootStatus];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"error"];
        [self.userTableView.mj_header endRefreshing];
    }];
}

- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
}

@end
