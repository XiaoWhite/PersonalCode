//
//  ResultTableViewController.h
//  UISearchControllerTest
//
//  Created by NCS on 18/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewController : UITableViewController<UISearchResultsUpdating>

@property (retain, nonatomic) NSMutableArray *dataList;

@property (copy, nonatomic) void(^dismisBlock)();

@end
