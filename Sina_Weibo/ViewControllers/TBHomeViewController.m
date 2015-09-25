//
//  TBHomeViewController.m
//  Sina_Weibo
//
//  Created by zym on 15/9/22.
//  Copyright © 2015年 zjt_zym. All rights reserved.
//

#import "TBHomeViewController.h"
#import "TBLibraryHeader.h"
#import "TBStatusCell.h"
#import "OAuthViewController.h"
#import "StatusModel.h"

@interface TBHomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation TBHomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    OAuthViewController *oauthView = [self.storyboard instantiateViewControllerWithIdentifier:@"OAuthViewController"];
//    [self presentViewController:oauthView
//                       animated:YES
//                     completion:^{
//                         
//                     }];
//
    
    self.dataSource = [NSMutableArray array];
    
    [[TBClientManager manager] friends_timelineWithSince_id:0
                                                     max_id:0
                                                      count:50
                                                       page:1
                                                   base_app:0
                                                    feature:0
                                                  trim_user:0
                                                    success:^(AFHTTPRequestOperation *operetion, id response) {
                                                        if ([response isKindOfClass:[NSDictionary class]]) {
                                                            NSArray *result = response[@"statuses"];
                                                            NSArray *statusModels = [StatusModel objectArrayWithKeyValuesArray:result];
                                                            self.dataSource = [NSMutableArray arrayWithArray:statusModels];
                                                            [self.homeTableView reloadData];
                                                        }
                                                        
                                                    } failure:^(AFHTTPRequestOperation *operetion, id response) {
                                                        
                                                    }];
    
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    [_homeTableView registerNib:[UINib nibWithNibName:@"TBStatusCell" bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([TBStatusCell class])];
}


#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TBStatusCell *cell =  [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TBStatusCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.statusModel = self.dataSource[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([TBStatusCell class])
                                    cacheByIndexPath:indexPath
                                       configuration:^(TBStatusCell *cell) {
                                               cell.statusModel = self.dataSource[indexPath.row];
                                           
                                       }];
}



@end
