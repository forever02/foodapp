//
//  CityItem.h
//  ifoodieus
//
//  Created by dev on 5/24/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "CustomItem.h"

@interface CityItem : CustomItem

@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString * cityId;
@property (nonatomic, strong) NSString *cityDescription;
@property bool cityStatus;
@property bool cityDelete;
@property (nonatomic, strong) NSString *cityImage;
@property (nonatomic, strong) NSString *cityTitleImage;
@property (nonatomic, strong) NSString *cityBackImage;
@property (nonatomic, strong) NSString *cityGlobalImage;
@property (nonatomic, strong) NSString *cityGroupImage;


-(id)initWithDictionary:(NSDictionary *)dicParams;
-(id)initWithString:(NSString *)value;
-(NSString *)getStringOfItem;


@end
