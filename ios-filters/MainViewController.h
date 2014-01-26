//
//  MainViewController.h
//  ios-filters
//
//  Created by Shirmung Bielefeld on 1/26/14.
//  Copyright (c) 2014 Shirmung Bielefeld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
