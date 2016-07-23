//
//  HttpApi.m
//  ifoodieus
//
//  Created by dev on 5/24/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "HttpApi.h"
#import "define.h"
#import <AFHTTPRequestOperationManager.h>
#import "AppDelegate.h"

@implementation HttpApi
HttpApi *sharedObj = nil;
AFHTTPRequestOperationManager *manager;

+(id) sharedInstance{
    if(!sharedObj){
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            sharedObj = [[self alloc] init];
            manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
        });
    }
    return sharedObj;
}

-(void)getCitis:
      (void (^)(NSString *))completed
         Failed:(void (^) (NSString *))failed{
    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_API_URL, API_GET_CITIS];
    url = @"http://192.168.3.60/deedio/api/signup.php";
    NSDictionary *dicParams = @{};
    [manager POST:url
       parameters:dicParams
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              NSDictionary *dicResponse = (NSDictionary *)responseObject;
              if([[dicResponse objectForKey:@"msg"] isEqualToString:@"Success"]){
                  completed(responseObject);
              }else{
                  NSString *strErrorMsg = [dicResponse objectForKey:@"msg"];
                  failed(strErrorMsg);
              }
          }failure:^(AFHTTPRequestOperation *operation, NSError *error){
              failed(@"Network error!!!");
          }
     ];
}
-(void)getRestaurants:(NSString *) cityId
            SearchStr:(NSString *) searchStr
            Longitude:(NSString *) longitude
             Latitude:(NSString *) latitude
             Complete:(void (^)(NSString *))completed
               Failed:(void (^) (NSString *))failed{
    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_API_URL, API_GET_RESTAURANT];
    NSDictionary *dicParams = @{
                                @"in_category_id":cityId,
                                @"search_str":searchStr,
                                @"latitude":latitude,
                                @"longitude":longitude};
    [manager POST:url
       parameters:dicParams
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              NSDictionary *dicResponse = (NSDictionary *)responseObject;
              if([[dicResponse objectForKey:@"msg"] isEqualToString:@"Success"]){
                  completed(responseObject);
              }else{
                  NSString *strErrorMsg = [dicResponse objectForKey:@"msg"];
                  failed(strErrorMsg);
              }
          }failure:^(AFHTTPRequestOperation *operation, NSError *error){
              failed(@"Network error!!!");
          }
     ];
}
-(void)getRestaurantsWithLocation:(NSString *) clientToken
            Longitude:(NSString *) longitude
             Latitude:(NSString *) latitude
             Complete:(void (^)(NSString *))completed
               Failed:(void (^) (NSString *))failed{
    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_API_URL, API_GET_RESTAURANT_GEOLOCATION];
    NSDictionary *dicParams = @{
                                @"st_client_token":clientToken,
                                @"latitude":latitude,
                                @"longitude":longitude};
    [manager POST:url
       parameters:dicParams
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              NSDictionary *dicResponse = (NSDictionary *)responseObject;
              if([[dicResponse objectForKey:@"msg"] isEqualToString:@"Success"]){
                  completed(responseObject);
              }else{
                  NSString *strErrorMsg = [dicResponse objectForKey:@"msg"];
                  failed(strErrorMsg);
              }
          }failure:^(AFHTTPRequestOperation *operation, NSError *error){
              failed(@"Network error!!!");
          }
     ];
}
-(void)setFavourite:(NSString *) clientToken
          ProductId:(NSString *) productId
             Status:(NSString *) status
           Complete:(void (^)(NSString *))completed
             Failed:(void (^)(NSString *))failed{
    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_API_URL, API_SET_FAVOURITE];
    NSDictionary *dicParams = @{
                                @"st_client_token":clientToken,
                                @"in_product_id":productId,
                                @"in_status":status};
    [manager POST:url
       parameters:dicParams
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              NSDictionary *dicResponse = (NSDictionary *)responseObject;
              if([[dicResponse objectForKey:@"msg"] isEqualToString:@"Success"]){
                  completed(responseObject);
              }else{
                  NSString *strErrorMsg = [dicResponse objectForKey:@"msg"];
                  failed(strErrorMsg);
              }
          }failure:^(AFHTTPRequestOperation *operation, NSError *error){
              failed(@"Network error!!!");
          }
     ];
}
-(void)getFavoriteList:(NSString *) clientToken
             Longitude:(NSString *) longitude
              Latitude:(NSString *) latitude
                  City:(NSString *) city
              Complete:(void (^)(NSString *))completed
                Failed:(void (^) (NSString *))failed{
    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_API_URL, API_GET_FAVOURITE_LIST];
    NSDictionary *dicParams = @{
                                @"st_client_token":clientToken,
                                @"city":city,
                                @"latitude":latitude,
                                @"longitude":longitude};
    [manager POST:url
       parameters:dicParams
          success:^(AFHTTPRequestOperation *operation, id responseObject){
//              NSDictionary *dicResponse = (NSDictionary *)responseObject;
              completed(responseObject);
          }failure:^(AFHTTPRequestOperation *operation, NSError *error){
              failed(@"Network error!!!");
          }
     ];
}

-(void)getCustomerVoucherdetail:(NSString *) clientToken
                       Complete:(void (^)(NSString *))completed
                         Failed:(void (^) (NSString *))failed{
    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_API_URL, API_GET_CLIENT_VOUCHER_DETAIL];
//    clientToken = @"E976FBBD-CE55-4830-BAE7-54565589A945";
    NSDictionary *dicParams = @{
                                @"st_client_token":clientToken};
    [manager POST:url
       parameters:dicParams
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              completed(responseObject);
          }failure:^(AFHTTPRequestOperation *operation, NSError *error){
              failed(@"Network error!!!");
          }
     ];
}
-(void)getCustomerVoucherHistory:(NSString *) clientToken
                        Complete:(void (^)(NSString *))completed
                          Failed:(void (^) (NSString *))failed{
    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_API_URL, API_GET_CLIENT_VOUCHER_HISTORY];
//    clientToken = @"E976FBBD-CE55-4830-BAE7-54565589A945";
    NSDictionary *dicParams = @{
                                @"st_client_token":clientToken};
    [manager POST:url
       parameters:dicParams
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              completed(responseObject);
          }failure:^(AFHTTPRequestOperation *operation, NSError *error){
              failed(@"Network error!!!");
          }
     ];
}

-(void)getCustomerVoucherExpire:(NSString *) clientToken
                        Complete:(void (^)(NSString *))completed
                          Failed:(void (^) (NSString *))failed{
    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_API_URL, API_GET_CLIENT_VOUCHER_EXPIRED];
//    clientToken = @"E976FBBD-CE55-4830-BAE7-54565589A945";
    NSDictionary *dicParams = @{
                                @"st_client_token":clientToken};
    [manager POST:url
       parameters:dicParams
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              completed(responseObject);
          }failure:^(AFHTTPRequestOperation *operation, NSError *error){
              failed(@"Network error!!!");
          }
     ];
}
-(void)getCustomerVoucherReedim:(NSString *) clientToken
                        Complete:(void (^)(NSString *))completed
                          Failed:(void (^) (NSString *))failed{
    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_API_URL, API_GET_CLIENT_VOUCHER_REDEEM_DETAIL];
//    clientToken = @"E976FBBD-CE55-4830-BAE7-54565589A945";
    NSDictionary *dicParams = @{
                                @"st_client_token":clientToken};
    [manager POST:url
       parameters:dicParams
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              completed(responseObject);
          }failure:^(AFHTTPRequestOperation *operation, NSError *error){
              failed(@"Network error!!!");
          }
     ];
}
-(void)addCustomerVoucher:(NSString *)clientToken
         TotalQntyTypeOne:(NSString *) total_qnty_one
         TotalQntyTypeTwo:(NSString *) total_qnty_two
        TotalPriceTypeOne:(NSString *) total_price_one
        TotalPriceTypeTwo:(NSString *) total_price_two
                 Complete:(void (^) (NSString*)) completed
                   Failed:(void (^) (NSString *)) failed{
    
    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_API_URL, API_GET_CLIENT_ADD_VOUCHER];
    NSDictionary *dicParams = @{
                                @"st_client_token":clientToken,
    @"total_qnty_typeone":total_qnty_one,
    @"total_qnty_typetwo":total_qnty_two,
    @"total_price_typeone":total_price_one,
    @"total_price_typetwo":total_price_two};
    
    [manager POST:url
       parameters:dicParams
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              completed(responseObject);
          }failure:^(AFHTTPRequestOperation *operation, NSError *error){
              failed(@"Network error!!!");
          }
     ];
}

@end
