//
//  AccountViewController.m
//  ifoodieus
//
//  Created by dev on 5/18/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "AccountViewController.h"
#import "VoucherHistoryCell.h"
#import "VoucherViewController.h"
#import "SearchViewController.h"
#import "RestaurantTermsViewController.h"
#import "FavoriteViewController.h"
#import "AboutUSViewContoller.h"
#import "MapViewController.h"
#import "common.h"
#import "HttpApi.h"
#import "VoucherReedim.h"
#import "voucherItem.h"
#import "VoucherExpiredItem.h"

int accountcurrentStep;
@implementation AccountViewController
@synthesize dataArray;

-(void)viewDidLoad{
    [self initValues];
    [self initViews];
}

-(void)viewWillAppear:(BOOL)animated
{
    [[common sharedCommon] showSpinner:self.view];
    [self accountClicked:nil];
}

//set initial view
-(void)initValues{
    accountcurrentStep = 1;
    dataArray = [[NSMutableArray alloc] init];
    
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

    [self.viewStep1 setHidden:NO];
    [self.viewStep2 setHidden:YES];
    [self.txt_Title setText:@"Information about your vouchers"];
}

- (IBAction)accountClicked:(id)sender {
    accountcurrentStep = 1;
    [[common sharedCommon] showSpinner:self.view];
    [self.btt_account setImage:[UIImage imageNamed:@"account_selected.png"] forState:UIControlStateNormal];
    [self.btt_history setImage:[UIImage imageNamed:@"history_normal.png"] forState:UIControlStateNormal];
    [self.btt_reedem setImage:[UIImage imageNamed:@"reedem_normal.png"] forState:UIControlStateNormal];
    [self.btt_expired setImage:[UIImage imageNamed:@"expired_normal.png"] forState:UIControlStateNormal];
    [self.viewStep1 setHidden:NO];
    [self.viewStep2 setHidden:YES];
    [self.txt_Title setText:@"Information about your vouchers"];
    [[HttpApi sharedInstance] getCustomerVoucherdetail:[common sharedCommon].uniqueId
        Complete:^(NSString *responseObject){
            NSDictionary *dicResponse = (NSDictionary *)responseObject;
            if([[dicResponse objectForKey:@"msg"] isEqualToString:@"Success"]){
                
                [self getAccountData:responseObject];
            }else{
//                [favoriteList removeAllObjects];
//                [self.favoriteTable reloadData];
                [[common sharedCommon] hiddenSpinner:self.view];
            }
        } Failed:^(NSString *strError) {
            [[common sharedCommon] hiddenSpinner:self.view];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"iFoodieus" message:@"No network access please try again!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
    }];

}
-(void)getAccountData:(NSString*) response
{
    NSDictionary *dicResponse = (NSDictionary *)response;
    NSDictionary *dicResponse1 = [dicResponse objectForKey:@"data"];
    NSString *used = [dicResponse1 objectForKey:@"total_voucher_used"];
    NSString *voucher = [dicResponse1 objectForKey:@"total_voucher"];
    NSString *remaining = [dicResponse1 objectForKey:@"total_voucher_remaining"];
    NSString *saving = [dicResponse1 objectForKey:@"saving"];
    
    [self.txt_Remaining setText:remaining];
    [self.txt_Savings setText:[NSString stringWithFormat:@"$%@",saving]];
    [self.txt_Used setText:used];
    [[common sharedCommon] hiddenSpinner:self.view];
    
}
- (IBAction)historyClicked:(id)sender {
    accountcurrentStep = 2;
    [[common sharedCommon] showSpinner:self.view];
    [self.btt_account setImage:[UIImage imageNamed:@"account_normal.png"] forState:UIControlStateNormal];
    [self.btt_history setImage:[UIImage imageNamed:@"history_selected.png"] forState:UIControlStateNormal];
    [self.btt_reedem setImage:[UIImage imageNamed:@"reedem_normal.png"] forState:UIControlStateNormal];
    [self.btt_expired setImage:[UIImage imageNamed:@"expired_normal.png"] forState:UIControlStateNormal];
    [self.viewStep2 setHidden:NO];
    [self.viewStep1 setHidden:YES];
    [self.lblhistory_help setHidden:NO];
    [self.txt_Title setText:@"Your purchased vouchers history"];
    [[HttpApi sharedInstance] getCustomerVoucherHistory:[common sharedCommon].uniqueId
                                              Complete:^(NSString *responseObject){
                                                  NSDictionary *dicResponse = (NSDictionary *)responseObject;
                                                  if([[dicResponse objectForKey:@"msg"] isEqualToString:@"Success"]){
                                                      [self getHistoryData:dicResponse];
                                                  }else{
                                                      [dataArray removeAllObjects];
                                                      [self.voucherTable reloadData];
                                                      [[common sharedCommon] hiddenSpinner:self.view];
                                                  }
                                              } Failed:^(NSString *strError) {
                                                  [dataArray removeAllObjects];
                                                  [self.voucherTable reloadData];
                                                  [[common sharedCommon] hiddenSpinner:self.view];
                                                  UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"iFoodieus" message:@"No network access please try again!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                  [alert show];
                                              }];

}
-(void)getHistoryData:(NSDictionary*) response
{
    [dataArray removeAllObjects];
    NSArray *tmpList = (NSArray*)[response objectForKey:@"data"];
    for(int nIndex = 0; nIndex < tmpList.count; nIndex++){
        voucherItem *restItem = [[voucherItem alloc] initWithDictionary:[tmpList objectAtIndex:nIndex]];
        [dataArray addObject:restItem];
    }
    [self.voucherTable reloadData];
    [[common sharedCommon] hiddenSpinner:self.view];
    
}

- (IBAction)reedemClicked:(id)sender {
    accountcurrentStep = 3;
    [[common sharedCommon] showSpinner:self.view];
    [self.btt_account setImage:[UIImage imageNamed:@"account_normal.png"] forState:UIControlStateNormal];
    [self.btt_history setImage:[UIImage imageNamed:@"history_normal.png"] forState:UIControlStateNormal];
    [self.btt_reedem setImage:[UIImage imageNamed:@"reedem_selected.png"] forState:UIControlStateNormal];
    [self.btt_expired setImage:[UIImage imageNamed:@"expired_normal.png"] forState:UIControlStateNormal];
    [self.viewStep2 setHidden:NO];
    [self.viewStep1 setHidden:YES];
    [self.lblhistory_help setHidden:YES];
    [self.txt_Title setText:@"Your reedem vouchers history"];
    [[HttpApi sharedInstance] getCustomerVoucherReedim:[common sharedCommon].uniqueId
                                               Complete:^(NSString *responseObject){
                                                   NSDictionary *dicResponse = (NSDictionary *)responseObject;
                                                   if([[dicResponse objectForKey:@"msg"] isEqualToString:@"Success"]){
                                                       [self getReedimData:dicResponse];
                                                   }else{
                                                       [dataArray removeAllObjects];
                                                       [self.voucherTable reloadData];
                                                       [[common sharedCommon] hiddenSpinner:self.view];
                                                   }
                                               } Failed:^(NSString *strError) {
                                                   [dataArray removeAllObjects];
                                                   [self.voucherTable reloadData];
                                                   [[common sharedCommon] hiddenSpinner:self.view];
                                                   UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"iFoodieus" message:@"No network access please try again!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                   [alert show];
                                               }];
}
-(void)getReedimData:(NSDictionary*) response
{
    [dataArray removeAllObjects];
    NSArray *tmpList = (NSArray*)[response objectForKey:@"data"];
    for(int nIndex = 0; nIndex < tmpList.count; nIndex++){
        VoucherReedim *restItem = [[VoucherReedim alloc] initWithDictionary:[tmpList objectAtIndex:nIndex]];
        [dataArray addObject:restItem];
    }
    [self.voucherTable reloadData];
    [[common sharedCommon] hiddenSpinner:self.view];
}
- (IBAction)expiredClicked:(id)sender {
    accountcurrentStep = 4;
    [[common sharedCommon] showSpinner:self.view];
    [self.btt_account setImage:[UIImage imageNamed:@"account_normal.png"] forState:UIControlStateNormal];
    [self.btt_history setImage:[UIImage imageNamed:@"history_normal.png"] forState:UIControlStateNormal];
    [self.btt_reedem setImage:[UIImage imageNamed:@"reedem_normal.png"] forState:UIControlStateNormal];
    [self.btt_expired setImage:[UIImage imageNamed:@"expired_selected.png"] forState:UIControlStateNormal];
    [self.viewStep2 setHidden:NO];
    [self.viewStep1 setHidden:YES];
    [self.lblhistory_help setHidden:YES];
    [self.txt_Title setText:@"Your expired vouchers history"];
    [[HttpApi sharedInstance] getCustomerVoucherExpire:[common sharedCommon].uniqueId
                                               Complete:^(NSString *responseObject){
                                                   NSDictionary *dicResponse = (NSDictionary *)responseObject;
                                                   if([[dicResponse objectForKey:@"msg"] isEqualToString:@"Success"]){
                                                       [self getExpiredData:dicResponse];
                                                   }else{
                                                       [dataArray removeAllObjects];
                                                       [self.voucherTable reloadData];
                                                       [[common sharedCommon] hiddenSpinner:self.view];
                                                   }
                                               } Failed:^(NSString *strError) {
                                                   [dataArray removeAllObjects];
                                                   [self.voucherTable reloadData];
                                                   [[common sharedCommon] hiddenSpinner:self.view];
                                                   UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"iFoodieus" message:@"No network access please try again!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                   [alert show];
                                               }];
}
-(void)getExpiredData:(NSDictionary*) response
{
    [dataArray removeAllObjects];
    NSArray *tmpList = (NSArray*)[response objectForKey:@"data"];
    for(int nIndex = 0; nIndex < tmpList.count; nIndex++){
        VoucherExpiredItem *restItem = [[VoucherExpiredItem alloc] initWithDictionary:[tmpList objectAtIndex:nIndex]];
        [dataArray addObject:restItem];
    }
    [self.voucherTable reloadData];
    [[common sharedCommon] hiddenSpinner:self.view];
}
- (IBAction)getmoreClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VoucherViewController *vc = [sb instantiateViewControllerWithIdentifier:@"VoucherViewControllerIdentity"];
    //    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:NO completion:NULL];
}
- (IBAction)tellfriendClicked:(id)sender {
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
            NSString *recipients;
            NSString *email;
            recipients = @"mailto:?&subject=ifoodieus app";
            email = [NSString stringWithFormat:@"%@",recipients];
            email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
        }
    }
    else
    {
        NSString *recipients;
        NSString *email;
        
        recipients = @"mailto:?&subject=ifoodieus app";
        email = [NSString stringWithFormat:@"%@",recipients];
        email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
    }
}
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

-(void)displayComposerSheet
{
//    if (_mailToFriend)
    {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        // Fill out the email body text
        NSString *emailBody;
        emailBody=@"";
        NSArray *toRecipients = [NSArray arrayWithObjects:@"",nil];
        [picker setToRecipients:toRecipients];
        [picker setSubject:@"iFoodieUS app"];
        
        [picker setMessageBody:emailBody isHTML:NO];
        [self presentViewController:picker animated:YES completion:NULL];
    }
//    else{
//        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
//        picker.mailComposeDelegate = self;
//        // Fill out the email body text
//        NSString *emailBody;
//        emailBody=@"";
//        NSArray *toRecipients = [NSArray arrayWithObjects:@"info@ifoodie.com",nil];
//        [picker setToRecipients:toRecipients];
//        [picker setSubject:@"Feedback from ifoodie app user"];
//        
//        [picker setMessageBody:emailBody isHTML:NO];
//        [self presentModalViewController:picker animated:YES];
//    }
}
- (IBAction)infoClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RestaurantTermsViewController *vc = [sb instantiateViewControllerWithIdentifier:@"RestaurantTermsViewControllerIdentity"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    vc.mode = self.mode;
    [self presentViewController:vc animated:NO completion:NULL];
}

- (IBAction)globalClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AboutUSViewContoller *vc = [sb instantiateViewControllerWithIdentifier:@"AboutUSViewContollerIdentity"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    vc.mode = self.mode;
    [self presentViewController:vc animated:NO completion:NULL];
}

- (IBAction)nearbyClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MapViewControllerIdentity"];
//    vc.mode = self.mode;
    [self presentViewController:vc animated:NO completion:NULL];
}

- (IBAction)voucherClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VoucherViewController *vc = [sb instantiateViewControllerWithIdentifier:@"VoucherViewControllerIdentity"];
    //    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    vc.mode = self.mode;
    [self presentViewController:vc animated:NO completion:NULL];
}

- (IBAction)searchClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SearchViewControllerIdentity"];
//    vc.mode = self.mode;
    [self presentViewController:vc animated:NO completion:NULL];
}

- (IBAction)favorateClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FavoriteViewController *vc = [sb instantiateViewControllerWithIdentifier:@"FavoriteViewControllerIdentity"];
    [self presentViewController:vc animated:NO completion:NULL];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VoucherHistoryCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"VoucherHistoryCellIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) {
        cell = [[VoucherHistoryCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
    }
    if(accountcurrentStep == 2){
        voucherItem *item = dataArray[indexPath.row];
        cell.lblVoucherCount.text = item.voucherCount;
        cell.lblVoucherDate.text = item.voucherDate;
        if([item.voucherCount intValue]> 1){
            [cell.imgVoucher setImage:[UIImage imageNamed:@"mark_voucher_double.png"]];
        }else{
            [cell.imgVoucher setImage:[UIImage imageNamed:@"mark_voucher.png"]];
        }
    }else if(accountcurrentStep == 3){
        VoucherReedim *item = dataArray[indexPath.row];
        cell.lblVoucherCount.text = item.voucherCount;
        cell.lblVoucherDate.text = item.voucherDate;
        if([item.voucherCount intValue]> 1){
            [cell.imgVoucher setImage:[UIImage imageNamed:@"mark_voucher_double.png"]];
        }else{
            [cell.imgVoucher setImage:[UIImage imageNamed:@"mark_voucher.png"]];
        }
    }else if(accountcurrentStep == 4){
        VoucherExpiredItem *item = dataArray[indexPath.row];
        cell.lblVoucherCount.text = item.voucherCount;
        cell.lblVoucherDate.text = item.voucherDate;
        if([item.voucherCount intValue]> 1){
            [cell.imgVoucher setImage:[UIImage imageNamed:@"mark_voucher_double.png"]];
        }else{
            [cell.imgVoucher setImage:[UIImage imageNamed:@"mark_voucher.png"]];
        }
    }
    return cell;
}

#pragma mark UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    int a;
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
