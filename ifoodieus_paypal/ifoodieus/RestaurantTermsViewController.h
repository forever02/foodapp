//
//  RestaurantTermsViewController.h
//  ifoodieus
//
//  Created by dev on 5/18/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"

@interface RestaurantTermsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *txtHeader;
@property (weak, nonatomic) IBOutlet UIView *viewTerms;
@property (weak, nonatomic) IBOutlet UIView *viewWorks1;
@property (weak, nonatomic) IBOutlet UIView *viewWorks2;
@property (weak, nonatomic) IBOutlet UIView *viewWorks3;
@property (weak, nonatomic) IBOutlet UIView *viewNumbers;
@property (weak, nonatomic) IBOutlet UIButton *txtTerms;
@property (weak, nonatomic) IBOutlet UIButton *txtWorks;
@property (weak, nonatomic) IBOutlet UIButton *btt1;
@property (weak, nonatomic) IBOutlet UIButton *btt2;
@property (weak, nonatomic) IBOutlet UIButton *btt3;

//top bar
@property (weak, nonatomic) IBOutlet UIImageView *imt_top_background;
@property (weak, nonatomic) IBOutlet UIButton *img_top_info;
@property (weak, nonatomic) IBOutlet UILabel *txt_top_name;
@property (weak, nonatomic) IBOutlet UIButton *img_top_global;

@end
