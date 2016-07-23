//
//  voucherItem.m
//  ifoodieus
//
//  Created by dev on 5/26/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "voucherItem.h"

@implementation voucherItem

-(id)initWithDictionary:(NSDictionary *)dicParams{
    voucherItem *voucheritem = [[voucherItem alloc] init];
    
    voucheritem.voucherCount = [dicParams objectForKey:@"total_voucher"];
    voucheritem.voucherDate = [dicParams objectForKey:@"in_purchase_date"];
    return voucheritem;
}
-(id)initWithString:(NSString *)value{
    voucherItem *voucheritem = [[voucherItem alloc] init];

    return voucheritem;
}
-(NSString *)getStringOfItem{
    return @"";
}


@end
