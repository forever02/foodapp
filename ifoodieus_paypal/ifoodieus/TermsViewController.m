//
//  TermsViewController.m
//  ifoodieus
//
//  Created by dev on 5/17/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "TermsViewController.h"
#import "ChooseCity.h"
bool terSelected;
@implementation TermsViewController
-(void)viewDidLoad{
    [self initViews];
}

-(void)initViews{
    terSelected = true;
    [self.viewNumbers setHidden:YES];
    [self.viewTerms setHidden:NO];
    [self.viewWorks1 setHidden:YES];
    [self.viewWorks2 setHidden:YES];
    [self.viewWorks3 setHidden:YES];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
//Actions
- (IBAction)togoTerms:(id)sender {
    if(terSelected) return;
    terSelected = true;
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
    if(!terSelected) return;
    terSelected = false;
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

- (IBAction)gotoBack:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChooseCity *vc = [sb instantiateViewControllerWithIdentifier:@"ChooseCityIdentifier"];
    [self presentViewController:vc animated:NO completion:NULL];
}
@end
