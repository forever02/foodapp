//
//  VoucherViewController.m
//  ifoodieus
//
//  Created by dev on 5/18/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "VoucherViewController.h"
#import "SearchViewController.h"
#import "AccountViewController.h"
#import "VoucherHistoryCell.h"
#import "MapViewController.h"
#import "FavoriteViewController.h"
#import "common.h"
#import "HttpApi.h"
#import <QuartzCore/QuartzCore.h>

#define kPayPalEnvironment PayPalEnvironmentNoNetwork
@interface VoucherViewController()
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@end

int ivoucher1;
int ivoucher52;
int itotalvoucher;
float ipricevoucer;

@implementation VoucherViewController
@synthesize price;

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initValues];
    [self initViews];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [self initPaypal];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // Preconnect to PayPal early
    [self setPayPalEnvironment:self.environment];
}

- (void)setPayPalEnvironment:(NSString *)environment {
    self.environment = environment;
    [PayPalMobile preconnectWithEnvironment:environment];
}
//set initial view
-(void)initValues{
    ivoucher1 = 0;
    ivoucher52 = 0;
    itotalvoucher = 0;
    ipricevoucer = 0;
        
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
        [self.img_top_back setImage:img2 forState:UIControlStateNormal];

    [self.viewStep4 setHidden:NO];
}

//for view4
- (IBAction)voucher1_plus_click:(id)sender {
    ivoucher1++;
    if(ivoucher1 > 9){
        ivoucher1 = 0;
        ivoucher52++;
    }else{
        ivoucher52 = 0;
    }
    if(ivoucher52 > 5){
        ivoucher52 = 5;
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ifoodieus" message:@"You can buy upto 260 vouchers at one time" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    [self changeTextsView4];
}
- (IBAction)voucher1_minus_click:(id)sender {
    ivoucher1--;
    if(ivoucher1< 0){
        ivoucher1 = 0;
    }else{
        ivoucher52 = 0;
    }
    [self changeTextsView4];
}
- (IBAction)voucher52_plus_click:(id)sender {
    ivoucher52++;
    ivoucher1 = 0;
    if(ivoucher52 > 5){
        ivoucher52 = 5;
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ifoodieus" message:@"You can buy upto 260 vouchers at one time" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    [self changeTextsView4];
}
- (IBAction)voucher52_minus_click:(id)sender {
    ivoucher52--;
    ivoucher1 = 0;
    if(ivoucher52 < 0){
        ivoucher52 = 0;
    }
    [self changeTextsView4];
}
-(void)changeTextsView4{
    itotalvoucher = ivoucher1 + 52 * ivoucher52;
    ipricevoucer = 0.99 * ivoucher1 + 9.99 * ivoucher52;
    [self.txt_count1 setText:[NSString stringWithFormat:@"%d",ivoucher1]];
    [self.txt_count52 setText:[NSString stringWithFormat:@"%d",ivoucher52]];
    [self.txt_total_vouchers setText:[NSString stringWithFormat:@"%d",itotalvoucher]];
//    float newval = [NSString stringWithFormat:@"%.2f",ipricevoucer] floatValue;
    [self.txt_total_price setText:[NSString stringWithFormat:@"$%.2f",ipricevoucer]];
}
-(void)setproductIdentifier
{
    switch (ivoucher1) {
        case 1:
            _productIdentifier=@"com.ifoodieN.onevoucher";
            break;
        case 2:
            _productIdentifier=@"com.ifoodieN.twovoucher";
            break;
        case 3:
            _productIdentifier=@"com.ifoodieN.threevoucher";
            break;
        case 4:
            _productIdentifier=@"com.ifoodieN.fourvoucher";
            break;
        case 5:
            _productIdentifier=@"com.ifoodieN.fivevoucher";
            break;
        case 6:
            _productIdentifier=@"com.ifoodieN.sixvoucher";
            break;
        case 7:
            _productIdentifier=@"com.ifoodieN.sevenvoucher";
            break;
        case 8:
            _productIdentifier=@"com.ifoodieN.eightvoucher";
            break;
        case 9:
            _productIdentifier=@"com.ifoodieN.ninevoucher";
            break;
        default:
            break;
    }
    
    switch (ivoucher52) {
        case 1:
            _productIdentifier=@"com.ifoodieN.fiftytwovoucher";
            break;
        case 2:
            _productIdentifier=@"com.ifoodieN.onehundredfourvoucher";
            break;
        case 3:
            _productIdentifier=@"com.ifoodieN.onehundredfiftysixvoucher";
            break;
        case 4:
            _productIdentifier=@"com.ifoodieN.twohundredeightvoucher";
            break;
        case 5:
            _productIdentifier=@"com.ifoodieN.twohundredsixtyvoucher";
            break;

        default:
            break;
    }
}

- (IBAction)NearbyClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MapViewControllerIdentity"];
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
    [self presentViewController:vc animated:NO completion:NULL];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

//payment
//by itunes
-(IBAction)payByiTunes_clicked:(id)sender{
    if (ipricevoucer>0) {
        [self getProductInfo];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ifoodieus" message:@"To buy add vouchers!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(void)getProductInfo
{
    if([SKPaymentQueue canMakePayments])
    {
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObjects:_productIdentifier, nil]];
        request.delegate = self;
        [request start];
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ifoodieus" message:@"Products are loading...Try again!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark -
#pragma mark SKProductsRequestDelegate
-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *tmpproducts = response.products;
    if (tmpproducts.count != 0){
        self.products = tmpproducts;
        SKProduct *aproduct;
        for (int i=0; i<[_products count]; i++) {            
            aproduct=_products[i];
            if ([aproduct.productIdentifier isEqualToString:_productIdentifier]) {
                break;
            }
        }
        SKPayment *payment = [SKPayment paymentWithProduct:aproduct];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
}

#pragma mark SKPaymentTransactionObserver
-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions
{
    for(SKPaymentTransaction *transaction in transactions){
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [self addVouchers];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Error!"
                                                               message:transaction.error.localizedDescription
                                                              delegate:nil
                                                     cancelButtonTitle:nil
                                                     otherButtonTitles:@"OK", nil];
                [alert show];
                break;
        }
    }
}

-(void)addVouchers
{
    if(ivoucher52 == 0 && ivoucher1 == 0){
        return;
    }
    NSString *total_qnty_typetwo;
    NSString *total_qnty_typeone;
    NSString *total_price_typetwo;
    NSString *total_price_typeone;
    if(ivoucher52 == 0){
        total_qnty_typetwo = @"0";
    }
    if(ivoucher1 == 0){
        total_qnty_typeone = @"0";
    }
    total_price_typeone = [NSString stringWithFormat:@"%.2f", ivoucher1 * 0.99];
    total_price_typetwo = [NSString stringWithFormat:@"%.2f", ivoucher52 * 9.99];
    [[HttpApi sharedInstance] addCustomerVoucher:[common sharedCommon].uniqueId TotalQntyTypeOne:total_qnty_typeone TotalQntyTypeTwo:total_qnty_typetwo TotalPriceTypeOne:total_price_typeone TotalPriceTypeTwo:total_price_typetwo Complete:^(NSString *responseObject){
        NSDictionary *dicResponse = (NSDictionary *)responseObject;
        if([[dicResponse objectForKey:@"msg"] isEqualToString:@"Success"]){
//            self.restaurantItem.favourite = in_status;
//            if([self.restaurantItem.favourite isEqualToString:@"1"])
//                [self.imgFavorate setImage:[UIImage imageNamed:@"fav_mark.png"]];
//            else
//                [self.imgFavorate setImage:[UIImage imageNamed:@"unfav_mark.png"]];
        }
        [[common sharedCommon] hiddenSpinner:self.view];
    }Failed:^(NSString *strError){
        [[common sharedCommon] hiddenSpinner:self.view];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ifoodieus" message:@"Add to favorite Failed!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];

}


//paypal function

- (BOOL)acceptCreditCards {
    return self.payPalConfig.acceptCreditCards;
}

- (void)setAcceptCreditCards:(BOOL)acceptCreditCards {
    self.payPalConfig.acceptCreditCards = acceptCreditCards;
}
-(void)initPaypal
{
    
    // Set up payPalConfig
    _payPalConfig = [[PayPalConfiguration alloc] init];
#if HAS_CARDIO
    // You should use the PayPal-iOS-SDK+card-Sample-App target to enable this setting.
    // For your apps, you will need to link to the libCardIO and dependent libraries. Please read the README.md
    // for more details.
    _payPalConfig.acceptCreditCards = YES;
#else
    _payPalConfig.acceptCreditCards = NO;
#endif
    _payPalConfig.merchantName = @"Awesome Shirts, Inc.";
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    
    // Setting the languageOrLocale property is optional.
    //
    // If you do not set languageOrLocale, then the PayPalPaymentViewController will present
    // its user interface according to the device's current language setting.
    //
    // Setting languageOrLocale to a particular language (e.g., @"es" for Spanish) or
    // locale (e.g., @"es_MX" for Mexican Spanish) forces the PayPalPaymentViewController
    // to use that language/locale.
    //
    // For full details, including a list of available languages and locales, see PayPalPaymentViewController.h.
    
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    
    // Setting the payPalShippingAddressOption property is optional.
    //
    // See PayPalConfiguration.h for details.
    
//    _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
    self.environment = kPayPalEnvironment;
}

#pragma mark - Receive Single Payment

- (IBAction)payPaypal_clicked:(id)sender {
    // Remove our last completed payment, just for demo purposes.
    if(itotalvoucher <= 0){
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"iFoodieus" message:@"Please select voucher" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    self.resultText = nil;
    
    // Note: For purposes of illustration, this example shows a payment that includes
    //       both payment details (subtotal, shipping, tax) and multiple items.
    //       You would only specify these if appropriate to your situation.
    //       Otherwise, you can leave payment.items and/or payment.paymentDetails nil,
    //       and simply set payment.amount to your total charge.
    
    // Optional: include multiple items
    PayPalItem *item1;
    if(ivoucher52 > 0){
        item1 = [PayPalItem itemWithName:@"52 VOUCHERS $9.99"
                            withQuantity:ivoucher52
                               withPrice:[NSDecimalNumber decimalNumberWithString:@"9.99"]
                            withCurrency:@"USD"
                                 withSku:@""];    }
    else{
        item1 = [PayPalItem itemWithName:@"1 VOUCHER $0.99"
                            withQuantity:ivoucher1
                               withPrice:[NSDecimalNumber decimalNumberWithString:@"0.99"]
                            withCurrency:@"USD"
                                 withSku:@"Hip-00037"];
    }
    NSArray *items = @[item1];
    NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
    
    // Optional: include payment details
    NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"0"];
    NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:@"0"];
//    PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal
//                                                                               withShipping:shipping
//                                                                                    withTax:tax];
    
    NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = @"USD";
    payment.shortDescription = @"VOUCHERS";
    payment.items = items;  // if not including multiple items, then leave payment.items as nil
//    payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
    
    if (!payment.processable) {
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here.
    }
    
    // Update payPalConfig re accepting credit cards.
    self.payPalConfig.acceptCreditCards = self.acceptCreditCards;
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:self.payPalConfig
                                                                                                     delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    self.resultText = [completedPayment description];
//    [self showSuccess];
    
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    self.resultText = nil;
//    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
}


#pragma mark - Authorize Future Payments

- (IBAction)getUserAuthorizationForFuturePayments:(id)sender {
    
    PayPalFuturePaymentViewController *futurePaymentViewController = [[PayPalFuturePaymentViewController alloc] initWithConfiguration:self.payPalConfig delegate:self];
    [self presentViewController:futurePaymentViewController animated:YES completion:nil];
}


#pragma mark PayPalFuturePaymentDelegate methods

- (void)payPalFuturePaymentViewController:(PayPalFuturePaymentViewController *)futurePaymentViewController
                didAuthorizeFuturePayment:(NSDictionary *)futurePaymentAuthorization {
    NSLog(@"PayPal Future Payment Authorization Success!");
    self.resultText = [futurePaymentAuthorization description];
//    [self showSuccess];
    
    [self sendFuturePaymentAuthorizationToServer:futurePaymentAuthorization];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalFuturePaymentDidCancel:(PayPalFuturePaymentViewController *)futurePaymentViewController {
    NSLog(@"PayPal Future Payment Authorization Canceled");
//    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendFuturePaymentAuthorizationToServer:(NSDictionary *)authorization {
    // TODO: Send authorization to server
    NSLog(@"Here is your authorization:\n\n%@\n\nSend this to your server to complete future payment setup.", authorization);
}


#pragma mark - Authorize Profile Sharing

- (IBAction)getUserAuthorizationForProfileSharing:(id)sender {
    
    NSSet *scopeValues = [NSSet setWithArray:@[kPayPalOAuth2ScopeOpenId, kPayPalOAuth2ScopeEmail, kPayPalOAuth2ScopeAddress, kPayPalOAuth2ScopePhone]];
    
    PayPalProfileSharingViewController *profileSharingPaymentViewController = [[PayPalProfileSharingViewController alloc] initWithScopeValues:scopeValues configuration:self.payPalConfig delegate:self];
    [self presentViewController:profileSharingPaymentViewController animated:YES completion:nil];
}


#pragma mark PayPalProfileSharingDelegate methods

- (void)payPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController
             userDidLogInWithAuthorization:(NSDictionary *)profileSharingAuthorization {
    NSLog(@"PayPal Profile Sharing Authorization Success!");
    self.resultText = [profileSharingAuthorization description];
//    [self showSuccess];
    
    [self sendProfileSharingAuthorizationToServer:profileSharingAuthorization];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidCancelPayPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController {
    NSLog(@"PayPal Profile Sharing Authorization Canceled");
//    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendProfileSharingAuthorizationToServer:(NSDictionary *)authorization {
    // TODO: Send authorization to server
    NSLog(@"Here is your authorization:\n\n%@\n\nSend this to your server to complete profile sharing setup.", authorization);
}

@end
