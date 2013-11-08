//
//  FirstViewController.m
//  photon
//
//  Created by jtq6 on 11/1/13.
//  Copyright (c) 2013 Informatics Research and Development Lab. All rights reserved.
//

#import "IssuesViewController.h"
#import "IssueArticlesTVC.h"
#import "Issue.h"

@interface IssuesViewController ()

@end

NSMutableArray *issues;
Issue *currIssue;

@implementation IssuesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"Issues";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)refresh:(id)sender
{
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [APP_MGR.issuesMgr.issues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"IssueCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSInteger index = [indexPath row];
    UILabel *descLabel = (UILabel *)[cell.contentView viewWithTag:1];

    Issue *cellIssue = APP_MGR.issuesMgr.issues[index];
    // cell.textLabel.text = cellIssue.title;
    descLabel.text = cellIssue.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Navigation logic may go here. Create and push another view controller.
    // [self.navigationController pushViewController:detailViewController animated:YES];
    currIssue = APP_MGR.issuesMgr.issues[[indexPath row]];
    [self performSegueWithIdentifier:@"pushIssueArticles" sender:nil];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"pushIssueArticles"])
    {
        IssueArticlesTVC *issueArticlesTVC = segue.destinationViewController;
        issueArticlesTVC.issue = currIssue;
    }
}




@end
