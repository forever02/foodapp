//
//  RestaurantCell.h
//  ifoodieus
//
//  Created by dev on 5/17/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_restaurant;
@property (weak, nonatomic) IBOutlet UILabel *txt_Name;
@property (weak, nonatomic) IBOutlet UILabel *txt_Address;
@property (weak, nonatomic) IBOutlet UILabel *txt_Category;
@property (weak, nonatomic) IBOutlet UILabel *txt_Distance;
@property (weak, nonatomic) IBOutlet UIImageView *imgstar1;
@property (weak, nonatomic) IBOutlet UIImageView *imgstar2;
@property (weak, nonatomic) IBOutlet UIImageView *imgstar3;
@property (weak, nonatomic) IBOutlet UIImageView *imgstar4;
@property (weak, nonatomic) IBOutlet UIImageView *imgstar5;
@property (weak, nonatomic) IBOutlet UIButton *bttfav;

-(void)setStarRating:(NSInteger) num;
@end
