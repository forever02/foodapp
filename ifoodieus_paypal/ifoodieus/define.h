//
//  define.h
//  ifoodieus
//
//  Created by dev on 5/18/16.
//  Copyright © 2016 dev. All rights reserved.
//
typedef enum
{
    MODE1=0,
    MODE2,
    MODE3,
    MODE4,
    MODE5
} SelectedRestaurantMode;

#define SERVER_API_URL @"http://testifoodieapp.com/api/iphone/"
#define API_GET_CITIS @"city_list.php"
#define API_GET_RESTAURANT @"resturant_search.php"
#define API_GET_RESTAURANT_GEOLOCATION @"get_nearby_res.php"
#define API_SET_FAVOURITE @"client_addFavourite.php"
#define API_GET_FAVOURITE_LIST @"favouritelistByCustomer.php"
#define API_GET_CLIENT_VOUCHER_DETAIL @"customer_voucher_details.php"
#define API_GET_CLIENT_VOUCHER_HISTORY @"customer_voucher_history.php"
#define API_GET_CLIENT_VOUCHER_EXPIRED @"expired_voucher.php"
#define API_GET_CLIENT_VOUCHER_REDEEM_DETAIL @"customer_reedim_detail.php"
#define API_GET_CLIENT_ADD_VOUCHER @"customer_voucher.php"
