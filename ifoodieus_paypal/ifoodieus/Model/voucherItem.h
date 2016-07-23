//
//  voucherItem.h
//  ifoodieus
//
//  Created by dev on 5/26/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "CustomItem.h"

@interface voucherItem : CustomItem

@property (nonatomic, strong) NSString *voucherCount;
@property (nonatomic, strong) NSString *voucherDate;

-(id)initWithDictionary:(NSDictionary *)dicParams;
-(id)initWithString:(NSString *)value;
-(NSString *)getStringOfItem;
@end
