//
//  ViewController.m
//  UISearchControllerTest
//
//  Created by NCS on 18/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

#import "ViewController.h"
#import "ResultTableViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating>
{
    UISearchController *_searchController;
    
    NSMutableArray *dataList;
    NSMutableArray *filterArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // init data
    dataList = [NSMutableArray array];
    filterArray = [NSMutableArray array];
    
    for (int i = 0; i < 20; i++) {
        [dataList addObject:[NSString stringWithFormat:@"%d - GoodMorning",i]];
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = YES;
    [_searchController.searchBar sizeToFit];
    
    self.tableView.tableHeaderView = _searchController.searchBar;
    
    
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
    if (_searchController.active) {
        return filterArray.count;
    } else{
        return dataList.count;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (_searchController.active) {
        cell.textLabel.text = filterArray[indexPath.row];
    } else{
        cell.textLabel.text = dataList[indexPath.row];
    }
    

    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    _searchController.active = NO;
    [_searchController.searchBar resignFirstResponder];
}


#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSString *searchString = searchController.searchBar.text;
    
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",searchString];
    
    if (filterArray.count != 0) {
        [filterArray removeAllObjects];
    }
    
    filterArray = [NSMutableArray arrayWithArray:[dataList filteredArrayUsingPredicate:predicate]];
    
    [self.tableView reloadData];
    
    
}

@end
