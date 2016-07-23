//
//  common.h
//  ifoodieus
//
//  Created by dev on 5/24/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface common : NSObject{
    NSInteger *selectedCityId;
    NSString *uniqueId;
}

@property(nonatomic, strong) NSMutableArray *cityArray;
@property(nonatomic, strong) NSMutableArray *restaurantArray;
@property (nonatomic, strong) NSString *selectedCityId;
@property(nonatomic, strong) NSString *uniqueId;
@property(nonatomic,strong) NSMutableDictionary *storeImages;
@property(nonatomic,strong) UIButton *screenbackground;
@property(nonatomic,strong) UIImageView *loadingbackground;
@property(nonatomic,strong) UIImageView *loadinganimaiton;
@property float myLongitude;
@property float myLatitude;
@property bool dataLoaded;
@property (nonatomic, strong) NSString *selectedCityName;
+(common *)sharedCommon;
- (NSString *)GetUUID;
-(void)showSpinner:(UIView *)view;
-(void)hiddenSpinner:(UIView *)view;
//- (BOOL) connectedToNetwork;

@end
