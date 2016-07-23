//
//  VoucherViewController.h
//  ifoodieus
//
//  Created by dev on 5/18/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"
#import <StoreKit/StoreKit.h>
#import "PayPalMobile.h"

@interface VoucherViewController : UIViewController<PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate, SKPaymentTransactionObserver, SKProductsRequestDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imt_top_background;
@property (weak, nonatomic) IBOutlet UIButton *img_top_back;
@property (weak, nonatomic) IBOutlet UILabel *txt_top_name;

@property (weak, nonatomic) IBOutlet UIView *viewStep4;


//view 4
@property (weak, nonatomic) IBOutlet UILabel *txt_count1;
@property (weak, nonatomic) IBOutlet UILabel *txt_count52;
@property (weak, nonatomic) IBOutlet UILabel *txt_total_vouchers;
@property (weak, nonatomic) IBOutlet UILabel *txt_total_price;
@property (weak, nonatomic) IBOutlet UIView *termsView;
@property (weak, nonatomic) IBOutlet UIView *topView;


@property(nonatomic,strong) NSString *productIdentifier;
@property(nonatomic,strong) NSArray *products;
@property(readwrite) float price;


//for paypal

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) NSString *resultText;
@end
