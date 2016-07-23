//
//  HttpApi.h
//  ifoodieus
//
//  Created by dev on 5/24/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpApi : NSObject

+(id)sharedInstance;
-(void)getCitis:(void (^)(NSString *)) completed
         Failed:(void (^)(NSString *)) failed;

-(void)getRestaurants:(NSString *) cityId
            SearchStr:(NSString *) searchStr
            Longitude:(NSString *) longitude
             Latitude:(NSString *) latitude
             Complete:(void (^)(NSString *))completed
               Failed:(void (^) (NSString *))failed;

-(void)setFavourite:(NSString *) clientToken
          ProductId:(NSString *) productId
             Status:(NSString *) status
           Complete:(void (^)(NSString *))completed
             Failed:(void (^)(NSString *))failed;

-(void)getFavoriteList:(NSString *) clientToken
             Longitude:(NSString *) longitude
              Latitude:(NSString *) latitude
                  City:(NSString *) city
              Complete:(void (^)(NSString *))completed
                Failed:(void (^) (NSString *))failed;

-(void)getRestaurantsWithLocation:(NSString *) clientToken
                        Longitude:(NSString *) longitude
                         Latitude:(NSString *) latitude
                         Complete:(void (^)(NSString *))completed
                           Failed:(void (^) (NSString *))failed;

-(void)getCustomerVoucherdetail:(NSString *) clientToken
                       Complete:(void (^)(NSString *))completed
                         Failed:(void (^) (NSString *))failed;


-(void)getCustomerVoucherHistory:(NSString *) clientToken
                        Complete:(void (^)(NSString *))completed
                          Failed:(void (^) (NSString *))failed;

-(void)getCustomerVoucherExpire:(NSString *) clientToken
                       Complete:(void (^)(NSString *))completed
                         Failed:(void (^) (NSString *))failed;

-(void)getCustomerVoucherReedim:(NSString *) clientToken
                       Complete:(void (^)(NSString *))completed
                         Failed:(void (^) (NSString *))failed;

-(void)addCustomerVoucher:(NSString *)clientToken
          TotalQntyTypeOne:(NSString *) total_qnty_one
          TotalQntyTypeTwo:(NSString *) total_qnty_two
         TotalPriceTypeOne:(NSString *) total_price_one
         TotalPriceTypeTwo:(NSString *) total_price_two
                  Complete:(void (^) (NSString*)) completed
                    Failed:(void (^) (NSString *)) failed;
@end
