//
//  ResultTableViewController.m
//  UISearchControllerTest
//
//  Created by NCS on 18/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

#import "ResultTableViewController.h"

@interface ResultTableViewController ()
{
    NSMutableArray *filterArray;
}

@end

@implementation ResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    filterArray = [NSMutableArray array];
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
//    self.navigationController.navigationBar.translucent = YES;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return filterArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = filterArray[indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.dismisBlock) {
        self.dismisBlock();
    }
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchString = searchController.searchBar.text;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",searchString];
    
    if (filterArray.count != 0) {
        [filterArray removeAllObjects];
    }
    
    filterArray = [NSMutableArray arrayWithArray:[self.dataList filteredArrayUsingPredicate:predicate]];
    
    [self.tableView reloadData];
}

@end
