//
//  RestaurantTermsViewController.m
//  ifoodieus
//
//  Created by dev on 5/18/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "RestaurantTermsViewController.h"
#import "SearchViewController.h"
#import "VoucherViewController.h"
#import "AccountViewController.h"
#import "AboutUSViewContoller.h"
#import "MapViewController.h"
#import "FavoriteViewController.h"
#import "common.h"

bool termSelected;
@implementation RestaurantTermsViewController

-(void)viewDidAppear:(BOOL)animated{
    [self initValues];
    [self initViews];
}

-(void)initValues{
}
-(void)initViews{
    termSelected = true;
    if([common sharedCommon].dataLoaded){
        [self.txt_top_name setHidden:YES];
    }else{
        [self.txt_top_name setHidden:NO];
        [self.txt_top_name setText:[common sharedCommon].selectedCityName];
    }
    UIImage *img1 = [[common sharedCommon].storeImages valueForKey:@"title"];
    [self.imt_top_background setImage:img1];
    UIImage *img2 = [[common sharedCommon].storeImages valueForKey:@"back"];
    [self.img_top_info setImage:img2 forState:UIControlStateNormal];
    UIImage *img3 = [[common sharedCommon].storeImages valueForKey:@"global"];
    [self.img_top_global setImage:img3 forState:UIControlStateNormal];
    
    [self.viewNumbers setHidden:YES];
    [self.viewTerms setHidden:NO];
    [self.viewWorks1 setHidden:YES];
    [self.viewWorks2 setHidden:YES];
    [self.viewWorks3 setHidden:YES];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (IBAction)gotoBack:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SearchViewControllerIdentity"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    vc.mode = self.mode;
    [self presentViewController:vc animated:NO completion:NULL];
}
- (IBAction)globalClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AboutUSViewContoller *vc = [sb instantiateViewControllerWithIdentifier:@"AboutUSViewContollerIdentity"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;    [self presentViewController:vc animated:NO completion:NULL];
}
//Actions
- (IBAction)togoTerms:(id)sender {
    if(termSelected) return;
    termSelected = true;
    [self.txtHeader setText:@"Terms and Conditions"];
    UIImage *img1 = [UIImage imageNamed:@"btt_terms_pressed.png"];
    [self.txtTerms setImage:img1 forState:UIControlStateNormal];
    UIImage *img2 = [UIImage imageNamed:@"btt_how_to_works_normal.png"];
    [self.txtWorks setImage:img2 forState:UIControlStateNormal];
    [self.viewNumbers setHidden:YES];
    [self.viewTerms setHidden:NO];
    [self.viewWorks1 setHidden:YES];
    [self.viewWorks2 setHidden:YES];
    [self.viewWorks3 setHidden:YES];
    
}
- (IBAction)gotoWorks:(id)sender {
    if(!termSelected) return;
    termSelected = false;
    [self.txtHeader setText:@"How application works"];
    UIImage *img1 = [UIImage imageNamed:@"btt_terms_normal.png"];
    [self.txtTerms setImage:img1 forState:UIControlStateNormal];
    UIImage *img2 = [UIImage imageNamed:@"btt_how_to_works_pressed.png"];
    [self.txtWorks setImage:img2 forState:UIControlStateNormal];
    [self.viewNumbers setHidden:NO];
    [self.viewTerms setHidden:YES];
    [self.viewWorks1 setHidden:NO];
    [self.viewWorks2 setHidden:YES];
    [self.viewWorks3 setHidden:YES];
    [self click1:nil];
}
- (IBAction)click1:(id)sender {
    [self.viewWorks1 setHidden:NO];
    [self.viewWorks2 setHidden:YES];
    [self.viewWorks3 setHidden:YES];
    UIImage *img1 = [UIImage imageNamed:@"btt_1_pressed.png"];
    [self.btt1 setImage:img1 forState:UIControlStateNormal];
    UIImage *img2 = [UIImage imageNamed:@"btt_2_normal.png"];
    [self.btt2 setImage:img2 forState:UIControlStateNormal];
    UIImage *img3 = [UIImage imageNamed:@"btt_3_normal.png"];
    [self.btt3 setImage:img3 forState:UIControlStateNormal];
}
- (IBAction)click2:(id)sender {
    [self.viewWorks1 setHidden:YES];
    [self.viewWorks2 setHidden:NO];
    [self.viewWorks3 setHidden:YES];
    UIImage *img1 = [UIImage imageNamed:@"btt_1_normal.png"];
    [self.btt1 setImage:img1 forState:UIControlStateNormal];
    UIImage *img2 = [UIImage imageNamed:@"btt_2_pressed.png"];
    [self.btt2 setImage:img2 forState:UIControlStateNormal];
    UIImage *img3 = [UIImage imageNamed:@"btt_3_normal.png"];
    [self.btt3 setImage:img3 forState:UIControlStateNormal];
}
- (IBAction)click3:(id)sender {
    [self.viewWorks1 setHidden:YES];
    [self.viewWorks2 setHidden:YES];
    [self.viewWorks3 setHidden:NO];
    UIImage *img1 = [UIImage imageNamed:@"btt_1_normal.png"];
    [self.btt1 setImage:img1 forState:UIControlStateNormal];
    UIImage *img2 = [UIImage imageNamed:@"btt_2_normal.png"];
    [self.btt2 setImage:img2 forState:UIControlStateNormal];
    UIImage *img3 = [UIImage imageNamed:@"btt_3_pressed.png"];
    [self.btt3 setImage:img3 forState:UIControlStateNormal];
}


- (IBAction)NearbyClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MapViewControllerIdentity"];
//    vc.mode = self.mode;
    [self presentViewController:vc animated:NO completion:NULL];
}
- (IBAction)VoucherClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VoucherViewController *vc = [sb instantiateViewControllerWithIdentifier:@"VoucherViewControllerIdentity"];
    //    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    vc.mode = self.mode;
    [self presentViewController:vc animated:NO completion:NULL];
}
- (IBAction)SearchClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SearchViewControllerIdentity"];
//    vc.mode = self.mode;
    [self presentViewController:vc animated:NO completion:NULL];
}

- (IBAction)FavoriteClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FavoriteViewController *vc = [sb instantiateViewControllerWithIdentifier:@"FavoriteViewControllerIdentity"];
    [self presentViewController:vc animated:NO completion:NULL];
}
- (IBAction)AccountClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AccountViewController *vc = [sb instantiateViewControllerWithIdentifier:@"AccountViewControllerIdentity"];
//    vc.mode = self.mode;
    [self presentViewController:vc animated:NO completion:NULL];
}

@end
