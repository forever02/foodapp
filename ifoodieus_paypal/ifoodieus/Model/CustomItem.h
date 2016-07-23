//
//  CustomItem.h
//  ifoodieus
//
//  Created by dev on 5/24/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomItem : NSObject
-(id)initWithDictionary:(NSDictionary *)dicParams;
-(id)initWithString:(NSString *)value;
-(NSString *)getStringOfItem;

@end
