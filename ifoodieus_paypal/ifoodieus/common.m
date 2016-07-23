//
//  common.m
//  ifoodieus
//
//  Created by dev on 5/24/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "common.h"

@implementation common
@synthesize uniqueId;
@synthesize restaurantArray;
@synthesize cityArray;

+(common *)sharedCommon{
    static common *sharedCommon;
    @synchronized(self) {
        if(!sharedCommon){
            sharedCommon = [[common alloc] init];
        }
        return sharedCommon;
    }
}

- (NSString *)GetUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}

-(void)showSpinner:(UIView *)view{
    if(self.loadingbackground == nil){
        self.loadingbackground = [[UIImageView alloc] init];
    }
    if(self.loadinganimaiton == nil){
        self.loadinganimaiton = [[UIImageView alloc] init];
    }
    if(self.screenbackground == nil){
        self.screenbackground = [[UIButton alloc] init];
    }
    UIImage *loadingback = [UIImage imageNamed:@"loading.png"];
    UIImage *gif = [UIImage imageNamed:@"app_loading.gif"];
    [self.screenbackground setFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    [self.screenbackground setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1]];
    [self.loadinganimaiton setFrame:CGRectMake((view.frame.size.width - gif.size.width)/2, (view.frame.size.height - gif.size.height*1.5)/2, gif.size.width, gif.size.height)];
    [self.loadingbackground setFrame:CGRectMake((view.frame.size.width - loadingback.size.width)/2, (view.frame.size.height - loadingback.size.height)/2, loadingback.size.width, loadingback.size.height)];
//    imgView.animationDuration = 3.0f;
    self.loadinganimaiton.animationRepeatCount = 0;
    [self.loadinganimaiton startAnimating];
    [self.loadinganimaiton setImage:gif];
    [self.loadingbackground setImage:loadingback];
    [view addSubview:self.screenbackground];
    [view addSubview:self.loadingbackground];
    [view addSubview:self.loadinganimaiton];
}
-(void)hiddenSpinner:(UIView *)view{
    [self.screenbackground removeFromSuperview];
    [self.loadingbackground removeFromSuperview];
    [self.loadinganimaiton removeFromSuperview];
}
//- (BOOL) connectedToNetwork
//{
//    // Create zero addy
//    struct sockaddr_in zeroAddress;
//    bzero(&zeroAddress, sizeof(zeroAddress));
//    zeroAddress.sin_len = sizeof(zeroAddress);
//    zeroAddress.sin_family = AF_INET;
//    
//    // Recover reachability flags
//    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
//    SCNetworkReachabilityFlags flags;
//    
//    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
//    CFRelease(defaultRouteReachability);
//    
//    if (!didRetrieveFlags)
//    {
//        printf("Error. Could not recover network reachability flags\n");
//        return 0;
//    }
//    
//    BOOL isReachable = flags & kSCNetworkFlagsReachable;
//    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
//    return (isReachable && !needsConnection) ? YES : NO;
//}
@end
