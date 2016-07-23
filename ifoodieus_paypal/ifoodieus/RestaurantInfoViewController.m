//
//  RestaurantInfoViewController.m
//  ifoodieus
//
//  Created by dev on 5/19/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "RestaurantInfoViewController.h"
#import "AccountViewController.h"
#import "VoucherHistoryCell.h"
#import "VoucherViewController.h"
#import "SearchViewController.h"
#import "RestaurantTermsViewController.h"
#import "FavoriteViewController.h"
#import "MapViewController.h"
#import "ChooseCity.h"
#import "common.h"
#import <UIImageView+WebCache.h>
#import "HttpApi.h"
#import <MessageUI/MessageUI.h>

int currentStep;

@implementation RestaurantInfoViewController

-(void)viewDidLoad{
    [super viewDidLoad];
}
-(void)viewDidAppear:(BOOL)animated{
    [self initValues];
    [self initViews];
}
//set initial view
-(void)initValues{
    currentStep = 0;
}
-(void)initViews{
    if([common sharedCommon].dataLoaded){
        [self.txt_top_name setHidden:YES];
    }else{
        [self.txt_top_name setHidden:NO];
        [self.txt_top_name setText:[common sharedCommon].selectedCityName];
    }
    [self.voucherbackgroundView setHidden:YES];
    UIImage *img1 = [[common sharedCommon].storeImages valueForKey:@"title"];
    [self.imt_top_background setImage:img1];
    UIImage *img2 = [[common sharedCommon].storeImages valueForKey:@"back"];
    [self.btt_top_info setImage:img2 forState:UIControlStateNormal];
    UIImage *img3 = [[common sharedCommon].storeImages valueForKey:@"global"];
    [self.btt_top_global setImage:img3 forState:UIControlStateNormal];

    [self.txt_restaurant setText:self.restaurantItem.productName];
    [self.lbVoucherRestaurantName1 setText:self.restaurantItem.productName];
    [self.lbVoucherRestaurantName2 setText:self.restaurantItem.productName];
    [self.lbVoucherRestaurantName3 setText:self.restaurantItem.productName];
    [self.txtAddress setText:self.restaurantItem.address];
    [self.txtCousine setText:self.restaurantItem.cousine];
    [self.txtDescription setText:self.restaurantItem.productDescription];
    if([self.restaurantItem.image containsString:@"jpeg"] || [self.restaurantItem.image containsString:@"png"]){
        [self.imgRestaurant sd_setImageWithURL:[NSURL URLWithString:self.restaurantItem.image]];
    }else{
        [self.imgRestaurant setImage:[UIImage imageNamed:@"restaurant.png"]];
    }
    NSMutableArray *imgstarArr =  [[NSMutableArray alloc] initWithObjects:self.imgstar1,self.imgstar2,self.imgstar3,self.imgstar4,self.imgstar5, nil];
    for(int i = 0; i < imgstarArr.count; i++){
        if(i >= [self.restaurantItem.rating intValue]){
            [imgstarArr[i] setHidden:YES];
        }else{
            [imgstarArr[i] setHidden:NO];
        }
    }
    NSMutableArray *imgbagArr =  [[NSMutableArray alloc] initWithObjects:self.imgbag1,self.imgbag2,self.imgbag3,self.imgbag4, nil];
    for(int i = 0; i < imgbagArr.count; i++){
        if(i >= [self.restaurantItem.bags intValue]){
            [imgbagArr[i] setHidden:YES];
        }else{
            [imgbagArr[i] setHidden:NO];
        }
    }
    if([self.restaurantItem.favourite isEqualToString:@"0"]){
        [self.imgFavorate setImage:[UIImage imageNamed:@"unfav_mark.png"]];
    }else{
        [self.imgFavorate setImage:[UIImage imageNamed:@"fav_mark.png"]];
    }
    self.txtSaveValue.transform = CGAffineTransformMakeRotation(-3.14/10);
    if(self.restaurantItem.discount == nil){
        [self.txtSaveValue setText:@"$10"];
    }else{
        [self.txtSaveValue setText:[NSString stringWithFormat:@"$%@", self.restaurantItem.discount]];
    }
    
    //for voucher
    
    [self.viewStep1 setHidden:YES];
    [self.viewStep2 setHidden:YES];
    [self.viewStep3 setHidden:YES];
}
- (IBAction)resignClick:(id)sender {
    [self.input_check resignFirstResponder];
    [self.input_checktotal resignFirstResponder];
    [self.input_servername resignFirstResponder];
}

//actions
- (IBAction)gotoBack:(id)sender {
    currentStep--;
    if(currentStep < 1){
        currentStep = 1;
//        [self SearchClicked:nil];
    }
    
    [self.viewStep1 setHidden:YES];
    [self.viewStep2 setHidden:YES];
    [self.viewStep3 setHidden:YES];
    switch (currentStep) {
        case 1:
            [self.viewStep1 setHidden:NO];
            break;
        case 2:
            [self.viewStep2 setHidden:NO];
            break;
        case 3:
            [self.viewStep3 setHidden:NO];
            break;
        default:
            break;
    }
}

-(IBAction)checkHelp_clicked:(id)sender{
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ifoodieus" message:@"The check number should be on top of your bill" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(IBAction)serverNameHelp_clicked:(id)sender{
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ifoodieus" message:@"This is server/waiter name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(IBAction)checkTotalHelp_clicked:(id)sender{
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ifoodieus" message:@"Please put your check total here not including tax or gratuity. This discount is applied toward your food portion of the bill." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
-(IBAction)gotoView1:(id)sender
{
    [self.voucherbackgroundView setHidden:NO];
    [self.restaurantView setHidden:YES];
    [self.viewStep1 setHidden:NO];
    [self.viewStep2 setHidden:YES];
    [self.viewStep3 setHidden:YES];
    currentStep = 1;
    
}

- (IBAction)gotoView2:(id)sender {
    
    if ([[_input_check.text stringByTrimmingCharactersInSet:
          [NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ifoodieus" message:@"Please enter the check# or bill number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([[_input_servername.text stringByTrimmingCharactersInSet:
              [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] ==0){
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ifoodieus" message:@"Please enter the server/waiter name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else if([[_input_checktotal.text stringByTrimmingCharactersInSet:
               [NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0){
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ifoodieus" message:@"Please enter the check total(Bill)" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else if([[_input_checktotal.text stringByTrimmingCharactersInSet:
              [NSCharacterSet whitespaceAndNewlineCharacterSet]]floatValue]<[_minBill floatValue]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ifoodieus" message:[NSString stringWithFormat:@"To get the discount your bill must have to be greater than or equal to $%@.0",_minBill] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        [self.viewStep1 setHidden:YES];
        [self.viewStep2 setHidden:NO];
        [self.viewStep3 setHidden:YES];
        currentStep = 2;
        
        self.lb_check.text = self.input_check.text;
        self.lb_checktotal.text = self.input_checktotal.text;
        self.lb_servername.text = [NSString stringWithFormat:@"$%@", self.input_servername.text];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM/dd/YYYY"];
        self.lb_date.text = [formatter stringFromDate:[NSDate date]];
    }
}
- (IBAction)clickTerms:(id)sender {
    [UIView beginAnimations:@"slideDown" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.4f];
    [UIView setAnimationDelegate:(id)self];
    
    [self.termsView setCenter:CGPointMake(self.termsView.frame.size.width/2, self.topView.frame.size.height + self.termsView.frame.size.height/2)];
    [UIView commitAnimations];
}
- (IBAction)clickTermsOk:(id)sender {
    [UIView beginAnimations:@"slideUp" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.4f];
    [UIView setAnimationDelegate:(id)self];
    
    [self.termsView setCenter:CGPointMake(self.termsView.frame.size.width/2, -self.termsView.frame.size.height/2)];
    
    [UIView commitAnimations];
}

- (IBAction)gotoView3:(id)sender {
    [self.viewStep1 setHidden:YES];
    [self.viewStep2 setHidden:YES];
    [self.viewStep3 setHidden:NO];
    currentStep = 3;
    _lb_v3_check.text = self.input_check.text;
    _lb_v3_originaltotal.text = [NSString stringWithFormat:@"$%@", self.input_checktotal.text];
    _lb_v3_discount.text = @"-$10";
    _lb_v3_newtotal.text = [NSString stringWithFormat:@"$%d", [self.input_checktotal.text intValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/YYYY"];
    _lb_v3_today.text = [formatter stringFromDate:[NSDate date]];
}

- (IBAction)resignFirst:(id)sender {
    [self.input_check resignFirstResponder];
    [self.input_checktotal resignFirstResponder];
    [self.input_servername resignFirstResponder];
}


//textField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
}


//actions

- (IBAction)callClicked:(id)sender {
    int phoneNum = [self.restaurantItem.phone intValue];
    NSURL *num = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%d", phoneNum]];
    if([[UIApplication sharedApplication] canOpenURL:num]){
        [[UIApplication sharedApplication] openURL:num];
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"iFoodieus" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)directionClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iFoodieUS"
                                                                                         message:[NSString stringWithFormat:@"%@\nAddress : %@", self.restaurantItem.productName, self.restaurantItem.address] delegate:nil cancelButtonTitle:@"OK"
                                                                               otherButtonTitles:nil];
    [alert show];

}

- (IBAction)mailClicked:(id)sender {
//    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
//    if([MFMessageComposeViewController canSendText])
//    {
//        NSString *_saving = [NSString stringWithFormat:@"$%@", self.restaurantItem.discount];
//        controller.body = [NSString stringWithFormat:@"I got $%@ discount using ifoodieus app at %@",_saving,self.restaurantItem.productName];
////        if ([comeFrom isEqualToString:@"Redeem"]) {
////            controller.body = [NSString stringWithFormat:@"I got $%@ discount using ifoodie app at %@",_saving,self.restaurantItem.productName];
////        }
////        else{
////            controller.body = [NSString stringWithFormat:@"Meet me at %@, %@",self.restaurantItem.productName,self.restaurantItem.address];
////        }
//        controller.recipients = [NSArray arrayWithObjects:@"", nil];
//        controller.messageComposeDelegate = (id)self;
//        [self presentViewController:mailComposer animated:YES completion:NULL];
////        [self presentModalViewController:controller animated:YES];
//    }
    
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if ([mailClass canSendMail]){
        mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        NSString *_saving = [NSString stringWithFormat:@"%@", self.restaurantItem.discount];
        NSArray *reciptArray = [[NSArray alloc] initWithObjects:self.restaurantItem.email1, self.restaurantItem.email1,self.restaurantItem.email3, nil];
//        NSString *email1 = self.restaurantItem.email1;
        [mailComposer setToRecipients:reciptArray];
        [mailComposer setSubject:@"ifoodieus user"];
        [mailComposer setMessageBody:[NSString stringWithFormat:@"I got $%@ discount using ifoodieus app at %@",_saving,self.restaurantItem.productName] isHTML:NO];
//        if ([comeFrom isEqualToString:@"Redeem"]) {
//            [mailComposer setMessageBody:[NSString stringWithFormat:@"I got $%@ discount using ifoodieus app at %@",_saving,self.restaurantItem.productName] isHTML:NO];
//        }
//        else{
//            [mailComposer setMessageBody:[NSString stringWithFormat:@"Meet me at %@, %@",self.restaurantItem.productName,self.restaurantItem.address] isHTML:NO];
//        }
        [self presentViewController:mailComposer animated:YES completion:NULL];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ifoodieus" message:@"Mail is not configured in your device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
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

-(IBAction)favBtn_clicked:(id)sender{
    [[common sharedCommon] showSpinner:self.view];
    NSString *in_status;
    if ([self.restaurantItem.favourite isEqualToString:@"0"]) {
        in_status=@"1";
    }
    else{
        in_status=@"0";
    }
    
    [[HttpApi sharedInstance] setFavourite:[common sharedCommon].uniqueId ProductId:self.restaurantItem.productId Status:in_status Complete:^(NSString *responseObject){
        NSDictionary *dicResponse = (NSDictionary *)responseObject;
        if([[dicResponse objectForKey:@"msg"] isEqualToString:@"Success"]){
            self.restaurantItem.favourite = in_status;
            if([self.restaurantItem.favourite isEqualToString:@"1"])
                [self.imgFavorate setImage:[UIImage imageNamed:@"fav_mark.png"]];
            else
                [self.imgFavorate setImage:[UIImage imageNamed:@"unfav_mark.png"]];
        }
        [[common sharedCommon] hiddenSpinner:self.view];
    }Failed:^(NSString *strError){
        [[common sharedCommon] hiddenSpinner:self.view];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ifoodieus" message:@"Add to favorite Failed!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}




- (IBAction)backClicked:(id)sender {
    currentStep--;
    if(currentStep < 0){
        currentStep = 0;
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SearchViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SearchViewControllerIdentity"];
        [self presentViewController:vc animated:NO completion:NULL];
    }
    [self.restaurantView setHidden:YES];
    [self.viewStep1 setHidden:YES];
    [self.viewStep2 setHidden:YES];
    [self.viewStep3 setHidden:YES];
    switch (currentStep) {
        case 0:
            [self.voucherbackgroundView setHidden:YES];
            [self.restaurantView setHidden:NO];
            break;
            
        case 1:
            [self.viewStep1 setHidden:NO];
            break;
        case 2:
            [self.viewStep2 setHidden:NO];
            break;
        case 3:
            [self.viewStep3 setHidden:NO];
            break;
        default:
            break;
    }
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
