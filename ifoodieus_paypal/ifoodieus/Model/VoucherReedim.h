//
//  VoucherReedim.h
//  ifoodieus
//
//  Created by dev on 5/26/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "CustomItem.h"

@interface VoucherReedim : CustomItem

@property (nonatomic, strong) NSString *voucherCount;
@property (nonatomic, strong) NSString *voucherDate;
@property (nonatomic, strong) NSString *restrantId;
@property (nonatomic, strong) NSString *restrantName;
@property (nonatomic, strong) NSString *checkNum;
@property (nonatomic, strong) NSString *serverName;
@property (nonatomic, strong) NSString *saving;


-(id)initWithDictionary:(NSDictionary *)dicParams;
-(id)initWithString:(NSString *)value;
-(NSString *)getStringOfItem;
@end
