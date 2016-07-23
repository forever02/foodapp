//
//  AboutUSViewContoller.m
//  ifoodieus
//
//  Created by dev on 5/19/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "AboutUSViewContoller.h"
#import "AccountViewController.h"
#import "VoucherHistoryCell.h"
#import "VoucherViewController.h"
#import "SearchViewController.h"
#import "RestaurantTermsViewController.h"
#import "FavoriteViewController.h"
#import "MapViewController.h"
#import "common.h"
@implementation AboutUSViewContoller

-(void)viewDidLoad{
    [self initValues];
    [self initViews];
}

//set initial view
-(void)initValues{
    
}
-(void)initViews{
       if([common sharedCommon].dataLoaded){
        [self.txt_top_name setHidden:YES];
    }else{
        [self.txt_top_name setHidden:NO];
        [self.txt_top_name setText:[common sharedCommon].selectedCityName];
    }
    UIImage *img1 = [[common sharedCommon].storeImages valueForKey:@"title"];
    [self.imt_top_background setImage:img1];
    UIImage *img2 = [[common sharedCommon].storeImages valueForKey:@"back"];
    [self.btt_top_info setImage:img2 forState:UIControlStateNormal];
    UIImage *img3 = [[common sharedCommon].storeImages valueForKey:@"global"];
    [self.btt_top_global setImage:img3 forState:UIControlStateNormal];

}


//actions
- (IBAction)writeusClicked:(id)sender {
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil)
    {
        // We must always check whether the current device is configured for sending emails
        if ([mailClass canSendMail])
        {
            [self displayComposerSheet];
        }
        else
        {
            [self launchMailAppOnDevice];
        }
    }
    else
    {
        [self launchMailAppOnDevice];
    }

}

-(void)displayComposerSheet
{
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        // Fill out the email body text
        NSString *emailBody;
        emailBody=@"";
        NSArray *toRecipients = [NSArray arrayWithObjects:@"info@ifoodieus.com",nil];
        [picker setToRecipients:toRecipients];
        [picker setSubject:@"Feedback from ifoodieus app user"];
        
        [picker setMessageBody:emailBody isHTML:NO];
//    [self presentModalViewController:picker animated:YES];
    [self presentViewController:picker animated:YES completion:nil];
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result1 error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result1)
    {
        case MFMailComposeResultCancelled:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"Mail Canceled" delegate:nil cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
            
            break;
        case MFMailComposeResultSaved:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"Mail Saved" delegate:nil cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
            break;
        case MFMailComposeResultSent:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"Mail Sent" delegate:nil cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
            break;
        case MFMailComposeResultFailed:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Sent Failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
            break;
        default:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Mail Not Sent" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
        NSString *recipients;
        //NSString *body;
        NSString *email;
        
        //if (mailTo==1){
        
        recipients = @"mailto:info@ifoodieus.com?&subject=Feedback from ifoodieus app user";
        email = [NSString stringWithFormat:@"%@",recipients];
        email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
    
}
- (IBAction)joinusClicked:(id)sender {
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"http://www.facebook.com/ifoodieapp"]];
}


- (IBAction)nearbyClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MapViewControllerIdentity"];
    [self presentViewController:vc animated:NO completion:NULL];
}

- (IBAction)infoClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RestaurantTermsViewController *vc = [sb instantiateViewControllerWithIdentifier:@"RestaurantTermsViewControllerIdentity"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:NO completion:NULL];
}

- (IBAction)voucherClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VoucherViewController *vc = [sb instantiateViewControllerWithIdentifier:@"VoucherViewControllerIdentity"];
    //    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:NO completion:NULL];
}

- (IBAction)searchClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SearchViewControllerIdentity"];
    [self presentViewController:vc animated:NO completion:NULL];
}

- (IBAction)favorateClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FavoriteViewController *vc = [sb instantiateViewControllerWithIdentifier:@"FavoriteViewControllerIdentity"];
    [self presentViewController:vc animated:NO completion:NULL];
}

- (IBAction)accountClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AccountViewController *vc = [sb instantiateViewControllerWithIdentifier:@"AccountViewControllerIdentity"];
    [self presentViewController:vc animated:NO completion:NULL];
}



-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
