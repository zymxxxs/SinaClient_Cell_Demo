//
//  MainViewController.m
//  SinaClient_Demo
//
//  Created by zym on 15/3/9.
//  Copyright (c) 2015年 zym. All rights reserved.
//

#import "HomeViewController.h"
#import "APPHeader.h"
#import "OAuthViewController.h"
#import "WeiboCell.h"

#import "StatusModel.h"

static NSString *homeTableViewCellIdentifier = @"homeTableViewCellIdentifier";


@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (nonatomic, strong) NSMutableArray *arraySource;

@end

@implementation HomeViewController

-(void)awakeFromNib
{
    NSArray *tempData = [NSArray arrayWithArray:[[TMCache sharedCache] objectForKey:@"homedata"]];
    self.arraySource = [NSMutableArray array];
    [tempData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            StatusModel *model = [[StatusModel alloc] initWithDictionary:obj error:nil];
            [_arraySource addObject:model];
        }
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"主页";
    
    
    [_homeTableView registerNib:[UINib nibWithNibName:@"WeiboCell" bundle:nil] forCellReuseIdentifier:homeTableViewCellIdentifier];
    
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    
    __weak typeof(self) weakSelf = self;
    [_homeTableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf headerRefresh];
    }];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"token"]) {
        [self performSegueWithIdentifier:@"model" sender:nil];
    }
}

#pragma mark - RefreshMethods
-(void)headerRefresh
{
    [[TTIClient shareInstance] friendsTimelineWithsource:@""
                                            access_token:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]
                                                since_id:0
                                                  max_id:0
                                                   count:30
                                                    page:1
                                                base_app:0
                                                 feature:0
                                               trim_user:0
                                                 success:^(AFHTTPRequestOperation *operetion, id response) {
                                                     if ([response isKindOfClass:[NSDictionary class]]) {
                                                         NSMutableArray *result = [NSMutableArray array];
                                                         [[response objectForKey:@"statuses"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                                             if ([obj isKindOfClass:[NSDictionary class]]) {
                                                                 StatusModel *model = [[StatusModel alloc] initWithDictionary:obj error:nil];
                                                                 [result addObject:model];
                                                             }
                                                         }];
                                                         self.arraySource = result;
                                                         [self.homeTableView reloadData];
                                                         [[TMCache sharedCache] setObject:[response objectForKey:@"statuses"] forKey:@"homedata"];
                                                     }
                                                     [_homeTableView.header endRefreshing];
                                                 } failure:^(AFHTTPRequestOperation *operetion, id response) {
                                                     [_homeTableView.header endRefreshing];
                                                     [SVProgressHUD showErrorWithStatus:[response objectForKey:@"error"]];
                                                 }];
}

#pragma  mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arraySource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusModel *statusModel = _arraySource[indexPath.row];
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:homeTableViewCellIdentifier];
    [cell reloadStatusModel:statusModel];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:homeTableViewCellIdentifier];
    StatusModel *statusModel = _arraySource[indexPath.row];
    [cell reloadStatusModel:statusModel];
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    height += 1;
    
    return height;
}

@end
