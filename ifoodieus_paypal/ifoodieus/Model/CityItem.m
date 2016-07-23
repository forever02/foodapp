//
//  CityItem.m
//  ifoodieus
//
//  Created by dev on 5/24/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "CityItem.h"

@implementation CityItem

-(id)initWithDictionary:(NSDictionary *)dicParams{
    CityItem *cityitem = [[CityItem alloc] init];
    cityitem.cityName = [dicParams objectForKey:@"st_category_name"];
    cityitem.cityId = [dicParams objectForKey:@"in_category_id"];
    cityitem.cityImage = [dicParams objectForKey:@"st_image"];
    cityitem.cityDescription = [dicParams objectForKey:@"st_cat_description"];
    cityitem.cityStatus = (bool)[dicParams objectForKey:@"flg_ac_status"];
    cityitem.cityDelete = (bool)[dicParams objectForKey:@"flg_is_delete"];
    cityitem.cityTitleImage = [dicParams objectForKey:@"st_nav1"];
    cityitem.cityGlobalImage = [dicParams objectForKey:@"st_glbbtn"];
    cityitem.cityGroupImage = [dicParams objectForKey:@"st_abtusbtn"];
    cityitem.cityBackImage = [dicParams objectForKey:@"st_arrbtn"];
    return cityitem;
}
-(id)initWithString:(NSString *)value{
    CityItem *cityitem = [[CityItem alloc] init];
    return cityitem;
}
-(NSString *)getStringOfItem{
    return @"";
}
@end
