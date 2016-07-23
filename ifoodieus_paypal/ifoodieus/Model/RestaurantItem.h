//
//  RestaurantItem.h
//  ifoodieus
//
//  Created by dev on 5/24/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "CustomItem.h"

@interface RestaurantItem : CustomItem
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *restaurantId;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productDescription;
@property (nonatomic, strong) NSString *foodish;
@property (nonatomic, strong) NSString *websiteURL;
@property (nonatomic, strong) NSString *hood;
@property (nonatomic, strong) NSString *cousine;
@property (nonatomic, strong) NSString *meals;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *email1;
@property (nonatomic, strong) NSString *email2;
@property (nonatomic, strong) NSString *email3;
@property (nonatomic, strong) NSString *discount;
@property (nonatomic, strong) NSString *minimumBill;
@property (nonatomic, strong) NSString *rating;
@property (nonatomic, strong) NSString *bags;
@property (nonatomic, strong) NSString *twitterId;
@property (nonatomic, strong) NSString *foodie;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *deleted;
@property (nonatomic, strong) NSString *vId;
@property (nonatomic, strong) NSString *clientToken;
@property (nonatomic, strong) NSString *favourite;

-(id)initWithDictionary:(NSDictionary *)dicParams;
-(id)initWithString:(NSString *)value;
-(NSString *)getStringOfItem;
@end
