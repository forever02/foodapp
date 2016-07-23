//
//  CustomItem.m
//  ifoodieus
//
//  Created by dev on 5/24/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "CustomItem.h"

@implementation CustomItem

-(id)initWithDictionary:(NSDictionary *)dicParams{
    CustomItem *item = [[CustomItem alloc] init];
    return item;
}
-(id)initWithString:(NSString *)value{
    CustomItem *item = [[CustomItem alloc] init];
    return item;
}
-(NSString *)getStringOfItem{
    return @"";
}
@end
