//
//  MainViewController.m
//  ios-filters
//
//  Created by Shirmung Bielefeld on 1/26/14.
//  Copyright (c) 2014 Shirmung Bielefeld. All rights reserved.
//

#import "MainViewController.h"
#import "FilterViewController.h"

@interface MainViewController () {
    NSArray *items;
    NSMutableArray *searchResults;
}

@end

@implementation MainViewController

@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        // Custom initialization
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Breeds" ofType:@"plist"];
    items = [[NSArray alloc] initWithContentsOfFile:path];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
    } else {
        return [items count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [[searchResults objectAtIndex:indexPath.row]  valueForKey:@"Title"];
    } else {
        cell.textLabel.text = [[items objectAtIndex:indexPath.row] valueForKey:@"Title"];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - UISearchDisplayController helper + delegate methods

- (void)handleSearchForString:(NSString *)searchString
{
    if ([searchString length] != 0) {
        for (NSDictionary *i in items) {
            if ([[i valueForKey:@"Title"] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound) {
                [searchResults addObject:i];
            }
        }
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    if (searchResults == nil) {
        searchResults = [[NSMutableArray alloc] init];
    } else {
        [searchResults removeAllObjects];
    }

    [self handleSearchForString:searchString];

	return YES;
}

@end
