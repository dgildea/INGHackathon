//
//  ViewController.m
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "ItemDetailViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController {
    BOOL isSearching;
    NSMutableArray *filteredList;
}
@synthesize mainTableView;
@synthesize items;
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Market";
    // Change button color
    //_sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    items = [[NSArray alloc] initWithObjects:@"Item No. 1", @"Item No. 2", @"Item No. 3", @"Item No. 4", @"Item No. 5", @"Item No. 6", nil];
    isSearching = NO;
    filteredList = [[NSMutableArray alloc] init];
}

- (void)viewDidLayoutSubviews
{
    self.navigationController.navigationBar.translucent = NO;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    // Usually the number of items in your array (the one that holds your list
    // Return the number of rows in the section.
    if (isSearching) {
        //If the user is searching, use the list in our filteredList array.
        return [filteredList count];
    } else {
        return [items count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ItemCell";
    
    UITableViewCell *cell = [mainTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString *title;
    if (isSearching && [filteredList count]) {
        //If the user is searching, use the list in our filteredList array.
        title = [filteredList objectAtIndex:indexPath.row];
    } else {
        title = [items objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = title;
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    // If you want to push another view upon tapping one of the cells on your table.
    
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)filterListForSearchText:(NSString *)searchText
{
    [filteredList removeAllObjects]; //clears the array from all the string objects it might contain from the previous searches
    
    for (NSString *title in items) {
        NSRange nameRange = [title rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (nameRange.location != NSNotFound) {
            [filteredList addObject:title];
        }
    }
}

- (void)filterContentForScope:(NSString*)searchText scope:(NSString*)scope {
	// Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
	[filteredList removeAllObjects];
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
    NSArray *tempArray = [items filteredArrayUsingPredicate:predicate];
    if (![scope isEqualToString:@"All"]) {
        // Further filter the array with the scope
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",@"6"];
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
    }
    filteredList = [NSMutableArray arrayWithArray:tempArray];
}


- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    //When the user taps the search bar, this means that the controller will begin searching.
    //mainTableView.hidden = YES;
    isSearching = YES;
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    //When the user taps the Cancel Button, or anywhere aside from the view.
    mainTableView.hidden = NO;
    isSearching = NO;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterListForSearchText:searchString]; // The method we made in step 7
    if ([searchString isEqualToString:@""])
    {
        mainTableView.hidden = NO;
    }
    else
    {
        mainTableView.hidden = YES;
    }
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForScope:[self.searchDisplayController.searchBar text] scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showItemDetail"]) {
        NSIndexPath *indexPath;
        if(isSearching)
        {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        }
        else
        {
            indexPath = [self.mainTableView indexPathForSelectedRow];
        }
        ItemDetailViewController *destViewController = segue.destinationViewController;
        if(isSearching)
        {
            destViewController.itemName = [filteredList objectAtIndex:indexPath.row];
        }
        else
        {
            destViewController.itemName = [items objectAtIndex:indexPath.row];
        }
    }
}

@end
