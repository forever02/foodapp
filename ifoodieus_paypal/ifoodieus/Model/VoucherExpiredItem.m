//
//  VoucherExpiredItem.m
//  ifoodieus
//
//  Created by dev on 5/26/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "VoucherExpiredItem.h"

@implementation VoucherExpiredItem

-(id)initWithDictionary:(NSDictionary *)dicParams{
    VoucherExpiredItem *voucheritem = [[VoucherExpiredItem alloc] init];
    
    voucheritem.voucherCount = [dicParams objectForKey:@"no_of_expired_voucher"];
    voucheritem.voucherDate = [dicParams objectForKey:@"in_expired_date"];
    return voucheritem;
}
-(id)initWithString:(NSString *)value{
    VoucherExpiredItem *voucheritem = [[VoucherExpiredItem alloc] init];
    
    return voucheritem;
}
-(NSString *)getStringOfItem{
    return @"";
}

@end
