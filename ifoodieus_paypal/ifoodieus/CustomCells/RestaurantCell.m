//
//  RestaurantCell.m
//  ifoodieus
//
//  Created by dev on 5/17/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "RestaurantCell.h"

@implementation RestaurantCell

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}
-(void)setStarRating:(NSInteger) num{
    NSMutableArray *imgstarArr =  [[NSMutableArray alloc] initWithObjects:self.imgstar1,self.imgstar2,self.imgstar3,self.imgstar4,self.imgstar5, nil];
    for(int i = 0; i < imgstarArr.count; i++){
        if(i >= num){
            [imgstarArr[i] setHidden:YES];
        }else{
            [imgstarArr[i] setHidden:NO];            
        }
    }
}
@end
