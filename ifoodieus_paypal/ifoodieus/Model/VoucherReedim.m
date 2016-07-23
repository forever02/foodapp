//
//  VoucherReedim.m
//  ifoodieus
//
//  Created by dev on 5/26/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "VoucherReedim.h"

@implementation VoucherReedim

-(id)initWithDictionary:(NSDictionary *)dicParams{
    VoucherReedim *voucheritem = [[VoucherReedim alloc] init];
    
    voucheritem.voucherCount = [dicParams objectForKey:@"total_bill"];
    voucheritem.voucherDate = [dicParams objectForKey:@"date"];
    
    
    voucheritem.restrantId = [dicParams objectForKey:@"restrnt_id"];
    voucheritem.restrantName = [dicParams objectForKey:@"restrnt_name"];
    voucheritem.checkNum = [dicParams objectForKey:@"check_num"];
    voucheritem.serverName = [dicParams objectForKey:@"server_name"];
    voucheritem.saving = [dicParams objectForKey:@"saving"];
    return voucheritem;
}
-(id)initWithString:(NSString *)value{
    VoucherReedim *voucheritem = [[VoucherReedim alloc] init];
    
    return voucheritem;
}
-(NSString *)getStringOfItem{
    return @"";
}
@end
