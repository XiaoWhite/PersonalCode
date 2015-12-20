//
//  SecondTableViewController.m
//  UISearchControllerTest
//
//  Created by NCS on 18/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

#import "SecondTableViewController.h"
#import "ResultTableViewController.h"

@interface SecondTableViewController ()<UISearchBarDelegate>
{
    UISearchController *_searchController;
    __weak ResultTableViewController *_resultController;
    
    NSMutableArray *dataList;
}
@end

@implementation SecondTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
    // init data
    dataList = [NSMutableArray array];
    
    for (int i = 0; i < 20; i++) {
        [dataList addObject:[NSString stringWithFormat:@"%d - GoodMorning",i]];
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    _resultController = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultTableViewController"];
    _resultController.dataList = dataList;
    _resultController.dismisBlock = ^{
        _searchController.active = NO;
    };
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:_resultController];
    _searchController.searchResultsUpdater = _resultController;
    
    [_searchController.searchBar sizeToFit];
    _searchController.searchBar.delegate = self;
    
    
    UISearchBar *temp = _searchController.searchBar;
//    temp.searchFieldBackgroundPositionAdjustment = UIOffsetMake(10, 10);
    temp.barTintColor = [UIColor whiteColor];
    
    self.tableView.tableHeaderView = temp;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.text = dataList[indexPath.row];
    
    return cell;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"search------------------");
}
@end
