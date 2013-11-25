//
//  TopicsTVC.m
//  photon
//
//  Created by jtq6 on 11/8/13.
//  Copyright (c) 2013 Informatics Research and Development Lab. All rights reserved.
//

#import "TopicsTVC.h"
#import "TopicKnownVC.h"
#import "TopicAddedVC.h"
#import "TopicImplicationsVC.h"

#define CELL_TEXT_LABEL_WIDTH 230.0
#define CELL_PADDING 10.0

NSDictionary *regTextAttributes;
NSDictionary *boldTextAttributes;


@implementation TopicsTVC


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
    shareButton.width = -1.0;
    self.navigationItem.rightBarButtonItem = shareButton;
    self.txtvSourceArticle.text = _article.title;
    self.txtfSourceArticleHeading.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
    regTextAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:13]};
    boldTextAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Bold" size:13]};
    

}

- (void)share:(id)sender
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return the number of rows in the section.
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 66;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    Article *rowArticle = _issue.articles[[indexPath row]];
//    NSString *title = rowArticle.title;
//    
//    CGSize constraintSize = CGSizeMake(CELL_TEXT_LABEL_WIDTH, MAXFLOAT);
//    CGSize titleTextSize = CGSizeMake(0.0, 0.0);
//    
//    if (title != nil)
//        titleTextSize = [title sizeWithFont:APP_MGR.tableFont constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
//    
//    return  titleTextSize.height + (2 * CELL_PADDING);
//}
//

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TopicsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    // configure the cell...
    switch ([indexPath row]) {
        case 0:
        {
            NSMutableAttributedString *aboutString = [[NSMutableAttributedString alloc] initWithString:@"What is already known on this topic?"];
            
            [aboutString setAttributes:regTextAttributes range:NSMakeRange(0, 8)];
            [aboutString setAttributes:boldTextAttributes range:NSMakeRange(8,13)];
            [aboutString setAttributes:regTextAttributes range:NSMakeRange(21, 15)];
            [cell.textLabel setAttributedText:aboutString];
            break;
        }
        case 1:
        {
            NSMutableAttributedString *addedString = [[NSMutableAttributedString alloc] initWithString:@"What is added by this report?"];
            
            [addedString setAttributes:regTextAttributes range:NSMakeRange(0, 8)];
            [addedString setAttributes:boldTextAttributes range:NSMakeRange(8,6)];
            [addedString setAttributes:regTextAttributes range:NSMakeRange(13, 16)];
            [cell.textLabel setAttributedText:addedString];
            break;
        }
        case 2:
        {
            NSMutableAttributedString *implString = [[NSMutableAttributedString alloc] initWithString:@"What are the implications for public health practice?"];
            
            [implString setAttributes:regTextAttributes range:NSMakeRange(0, 13)];
            [implString setAttributes:boldTextAttributes range:NSMakeRange(13,39)];
            [implString setAttributes:regTextAttributes range:NSMakeRange(52,1)];
            [cell.textLabel setAttributedText:implString];
            break;
        }
        default:
            break;
            
    }
    
    
    
    //cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    cell.textLabel.numberOfLines = 0;
    [cell.textLabel sizeToFit];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    UIImageView *bgi = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 66)];
    bgi.contentMode = UIViewContentModeScaleAspectFit;
    bgi.clipsToBounds = YES;
//    bgi.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"topics_BG"]];
    bgi.image = [UIImage imageNamed:@"topics_BG"];
    cell.backgroundView = bgi;
    cell.backgroundColor = [UIColor clearColor];

    
    //    UILabel *descLabel = (UILabel *)[cell.contentView viewWithTag:1];
    //    descLabel.numberOfLines = 0;
    //    descLabel.text = rowArticle.title;
    //    [descLabel sizeToFit];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Navigation logic may go here. Create and push another view controller.
    NSInteger row = [indexPath row];
    if (row == 0)
        [self performSegueWithIdentifier:@"pushTopicKnown" sender:nil];
    else if (row == 1)
        [self performSegueWithIdentifier:@"pushTopicAdded" sender:nil];
    else if (row == 2)
        [self performSegueWithIdentifier:@"pushTopicImplications" sender:nil];
    
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"pushTopicKnown"])
    {
        TopicKnownVC *topicKnownVC = segue.destinationViewController;
        topicKnownVC.article = _article;
        topicKnownVC.issue = _issue;
        
    }
    
    else if([segue.identifier isEqualToString:@"pushTopicAdded"])
    {
        TopicAddedVC *topicAddedVC = segue.destinationViewController;
        topicAddedVC.article = _article;
        topicAddedVC.issue = _issue;
        
    }
    
    else if([segue.identifier isEqualToString:@"pushTopicImplications"])
    {
        TopicImplicationsVC *topicImplicationsVC = segue.destinationViewController;
        topicImplicationsVC.article = _article;
        topicImplicationsVC.issue = _issue;
        
    }
}



@end
