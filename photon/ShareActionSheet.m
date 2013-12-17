//
//  ShareActionSheet.m
//  photon
//
//  Created by jtq6 on 12/13/13.
//  Copyright (c) 2013 Informatics Research and Development Lab. All rights reserved.
//

#import "ShareActionSheet.h"
#import <Social/Social.h>

@implementation ShareActionSheet

- (id)initToShareApp:(UIViewController *)parentVC
{
    
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"Share MMWR Express Using" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Mail", @"Message", @"Twitter", @"Facebook", nil];
    
    self.parentVC = parentVC;
    return self;
    
}

-(void)showView
{
    [self.actionSheet showInView:self.parentVC.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        // Mail
        case 0:
            [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
            [self showMailSheet];
        break;
        // Message
        case 1:
            [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
            [self showMessageSheet];
        break;
        // Twitter
        case 2:
            [self showTweetSheet];
        break;
        // Facebook
        case 3:
            [self showFacebookSheet];
        break;
    }

}

- (void)showTweetSheet
{
    //  Create an instance of the Tweet Sheet
    SLComposeViewController *tweetSheet = [SLComposeViewController
                                           composeViewControllerForServiceType:
                                           SLServiceTypeTwitter];
    
    // Sets the completion handler.  Note that we don't know which thread the
    // block will be called on, so we need to ensure that any required UI
    // updates occur on the main queue
    tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
        switch(result) {
            //  This means the user cancelled without sending the Tweet
            case SLComposeViewControllerResultCancelled:
            break;
            //  This means the user hit 'Send'
            case SLComposeViewControllerResultDone:
            break;
        }
    };
    
    //  Set the initial body of the Tweet
    [tweetSheet setInitialText:@"I’m using CDC’s MMWR Express mobile app.  Learn more about it here:"];
    
    //  Add an URL to the Tweet.  You can add multiple URLs.
    if (![tweetSheet addURL:[NSURL URLWithString:@"http://www.cdc.gov/mmwr/"]]){
        NSLog(@"Unable to add the URL!");
    }
    
    //  Presents the Tweet Sheet to the user
    [self.parentVC presentViewController:tweetSheet animated:NO completion:^{
        NSLog(@"Tweet sheet has been presented.");
    }];

    
}

- (void)showFacebookSheet
{
    SLComposeViewController *fbSheet = [SLComposeViewController
                                           composeViewControllerForServiceType:
                                           SLServiceTypeFacebook];
    
    // Sets the completion handler.  Note that we don't know which thread the
    // block will be called on, so we need to ensure that any required UI
    // updates occur on the main queue
    fbSheet.completionHandler = ^(SLComposeViewControllerResult result) {
        switch(result) {
                //  This means the user cancelled without sending the Tweet
            case SLComposeViewControllerResultCancelled:
                break;
                //  This means the user hit 'Send'
            case SLComposeViewControllerResultDone:
                break;
        }
    };
    
    //  Set the initial body
    [fbSheet setInitialText:@"I’m using CDC’s MMWR Express mobile app.  Learn more about it here:"];
    
    if (![fbSheet addURL:[NSURL URLWithString:@"http://www.cdc.gov/mmwr"]]){
        NSLog(@"Unable to add the URL!");
    }
    
    //  Presents the Tweet Sheet to the user
    [self.parentVC presentViewController:fbSheet animated:NO completion:^{
        NSLog(@"FaceBook sheet has been presented.");
    }];
    
    
    
}

- (void)showMailSheet
{
    
    self.mailVC = [[MFMailComposeViewController alloc] init];
    self.mailVC.mailComposeDelegate = self;
    [self.mailVC setMessageBody:@"I’m using CDC’s MMWR Express mobile app.  Learn more about it here:" isHTML:NO];

    [self.parentVC presentViewController:self.mailVC animated:YES completion:nil];
    
    
}

- (void)showMessageSheet
{

    self.msgVC = [[MFMessageComposeViewController alloc] init];
    self.msgVC.messageComposeDelegate = self;
    [self.msgVC setBody:@"I’m using CDC’s MMWR Express mobile app.  Learn more about it here:"];
    [self.parentVC presentViewController:self.msgVC animated:YES completion:nil];


}


- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

    [self.mailVC dismissViewControllerAnimated:YES completion:nil];

}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MessageComposeResultCancelled:
            NSLog(@"Result: SMS sending canceled");
            break;
        case MessageComposeResultSent:
            NSLog(@"Result: SMS sent");
            break;
        case MessageComposeResultFailed:
            NSLog(@"Result: SMS sending failed");
            break;
        default:
            NSLog(@"Result: SMS not sent");
            break;
    }
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self.msgVC dismissViewControllerAnimated:YES completion:NULL];
}




@end