//
//  ZWTopicViewController.m
//  Jokes
//
//  Created by zhe wu on 10/5/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "ZWTopicViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "ZWTopic.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "ZWTopicCell.h"

@interface ZWTopicViewController ()

/** common */
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *maxtime;
/** common */
@property (nonatomic, strong) NSMutableArray *topics;
/** common */
@property (nonatomic, strong) NSDictionary *params;
@end

static NSString * const ZWTopicCellID = @"topic";

@implementation ZWTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefresh];
}



- (void)setupTableView
{
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = ZWTitlesViewY + ZWTitlesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZWTopicCell class]) bundle:nil] forCellReuseIdentifier:ZWTopicCellID];
    
}

- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

- (void)loadNewTopics
{
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (self.params != params) return;
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.topics = [ZWTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.page = 0;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return;
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreTopics
{
    [self.tableView.mj_header endRefreshing];
    self.page++;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (self.params != params) return;
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *newtopics = [ZWTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:newtopics];
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return;
        [self.tableView.mj_footer endRefreshing];
    }];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZWTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ZWTopicCellID];
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZWTopic *topic = self.topics[indexPath.row];
    return topic.cellH;
}


@end
