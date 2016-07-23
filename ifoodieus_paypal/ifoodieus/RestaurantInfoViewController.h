//
//  RestaurantInfoViewController.h
//  ifoodieus
//
//  Created by dev on 5/19/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"
#import "RestaurantItem.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface RestaurantInfoViewController : UIViewController<MFMailComposeViewControllerDelegate, UITextFieldDelegate>{
    
    MFMailComposeViewController *mailComposer;
}

@property (weak, nonatomic) IBOutlet UIImageView *imt_top_background;
@property (weak, nonatomic) IBOutlet UIButton *btt_top_info;
@property (weak, nonatomic) IBOutlet UILabel *txt_top_name;
@property (weak, nonatomic) IBOutlet UIButton *btt_top_global;
@property (weak, nonatomic) IBOutlet UILabel *txt_restaurant;
@property (weak, nonatomic) IBOutlet UIImageView *imgFavorate;
@property (weak, nonatomic) IBOutlet UIImageView *imgRestaurant;
@property (weak, nonatomic) IBOutlet UILabel *txtAddress;
@property (weak, nonatomic) IBOutlet UILabel *txtCousine;
@property (weak, nonatomic) IBOutlet UITextView *txtDescription;
@property (weak, nonatomic) IBOutlet UIImageView *imgstar1;
@property (weak, nonatomic) IBOutlet UIImageView *imgstar2;
@property (weak, nonatomic) IBOutlet UIImageView *imgstar3;
@property (weak, nonatomic) IBOutlet UIImageView *imgstar4;
@property (weak, nonatomic) IBOutlet UIImageView *imgstar5;
@property (weak, nonatomic) IBOutlet UIImageView *imgbag4;
@property (weak, nonatomic) IBOutlet UIImageView *imgbag3;
@property (weak, nonatomic) IBOutlet UIImageView *imgbag2;
@property (weak, nonatomic) IBOutlet UIImageView *imgbag1;
@property (weak, nonatomic) IBOutlet UILabel *txtSaveValue;
@property (weak, nonatomic) IBOutlet UIView *restaurantView;

//for voucher
@property (weak, nonatomic) IBOutlet UIView *viewStep1;
@property (weak, nonatomic) IBOutlet UIView *viewStep2;
@property (weak, nonatomic) IBOutlet UIView *viewStep3;
@property (weak, nonatomic) IBOutlet UIImageView *voucherbackgroundView;

//view 1
@property (weak, nonatomic) IBOutlet UITextField *input_check;
@property (weak, nonatomic) IBOutlet UITextField *input_servername;
@property (weak, nonatomic) IBOutlet UITextField *input_checktotal;
@property(nonatomic,strong) NSString *minBill;
@property (weak, nonatomic) IBOutlet UILabel *lbVoucherRestaurantName1;

//view2
@property (weak, nonatomic) IBOutlet UILabel *lb_check;
@property (weak, nonatomic) IBOutlet UILabel *lb_servername;
@property (weak, nonatomic) IBOutlet UILabel *lb_date;
@property (weak, nonatomic) IBOutlet UILabel *lb_checktotal;
@property (weak, nonatomic) IBOutlet UILabel *lbVoucherRestaurantName2;

//view3
@property (weak, nonatomic) IBOutlet UILabel *lb_v3_any;
@property (weak, nonatomic) IBOutlet UILabel *lb_v3_check;
@property (weak, nonatomic) IBOutlet UILabel *lb_v3_today;
@property (weak, nonatomic) IBOutlet UILabel *lb_v3_originaltotal;
@property (weak, nonatomic) IBOutlet UILabel *lb_v3_discount;
@property (weak, nonatomic) IBOutlet UILabel *lb_v3_newtotal;
@property (weak, nonatomic) IBOutlet UILabel *lbVoucherRestaurantName3;


@property (weak, nonatomic) IBOutlet UIView *termsView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property RestaurantItem *restaurantItem;
@end
