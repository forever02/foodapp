//
//  RestaurantItem.m
//  ifoodieus
//
//  Created by dev on 5/24/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "RestaurantItem.h"

@implementation RestaurantItem

-(id)initWithDictionary:(NSDictionary *)dicParams{
    RestaurantItem *restaurantitem = [[RestaurantItem alloc] init];
    
    restaurantitem.productId = [dicParams objectForKey:@"in_product_id"];
    restaurantitem.restaurantId = [dicParams objectForKey:@"resturant_id"];
    restaurantitem.address = [dicParams objectForKey:@"address"];
    restaurantitem.productName = [dicParams objectForKey:@"st_product_name"];
    restaurantitem.productDescription = [dicParams objectForKey:@"st_product_description"];
    restaurantitem.foodish = [dicParams objectForKey:@"st_foodish"];
    restaurantitem.websiteURL = [dicParams objectForKey:@"st_website"];
    restaurantitem.hood = [dicParams objectForKey:@"st_hood"];
    restaurantitem.cousine = [dicParams objectForKey:@"st_cousine"];
    restaurantitem.meals = [dicParams objectForKey:@"st_meals"];
    restaurantitem.latitude = [dicParams objectForKey:@"st_lat"];
    restaurantitem.longitude = [dicParams objectForKey:@"st_long"];
    restaurantitem.email1 = [dicParams objectForKey:@"st_email"];
    restaurantitem.email2 = [dicParams objectForKey:@"st_emailtwo"];
    restaurantitem.email3 = [dicParams objectForKey:@"st_emailthree"];
    restaurantitem.discount = [dicParams objectForKey:@"st_discount"];
    restaurantitem.minimumBill = [dicParams objectForKey:@"st_minimumBill"];
    restaurantitem.rating = [dicParams objectForKey:@"st_rating"];
    restaurantitem.bags = [dicParams objectForKey:@"bags"];
    restaurantitem.twitterId = [dicParams objectForKey:@"twitter_id"];
    restaurantitem.foodie = [dicParams objectForKey:@"st_foodie"];
    NSString *distens = [dicParams objectForKey:@"distance"];
    NSInteger dis = [distens integerValue];
    float distance = dis*0.6214;
    restaurantitem.distance = [NSString stringWithFormat:@"%.2f",distance];
    restaurantitem.phone = [dicParams objectForKey:@"phone"];
    restaurantitem.price = [dicParams objectForKey:@"price"];
    restaurantitem.image = [dicParams objectForKey:@"st_image"];
    restaurantitem.status = [dicParams objectForKey:@"flg_ac_status"];
    restaurantitem.deleted = [dicParams objectForKey:@"flg_is_delete"];
    restaurantitem.vId = [dicParams objectForKey:@"st_vid"];
    restaurantitem.clientToken = [dicParams objectForKey:@"st_client_token"];
    restaurantitem.favourite = [dicParams objectForKey:@"favourite"];

    return restaurantitem;
}
-(id)initWithString:(NSString *)value{
    RestaurantItem *restaurantitem = [[RestaurantItem alloc] init];
    return restaurantitem;
}
-(NSString *)getStringOfItem{
    return @"";
}

@end
