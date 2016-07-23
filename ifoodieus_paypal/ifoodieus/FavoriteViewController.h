//
//  FavoriteViewController.h
//  ifoodieus
//
//  Created by dev on 5/25/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *imt_top_background;
@property (weak, nonatomic) IBOutlet UIButton *img_top_info;
@property (weak, nonatomic) IBOutlet UILabel *txt_top_name;
@property (weak, nonatomic) IBOutlet UIButton *img_top_global;
@property (weak, nonatomic) IBOutlet UITableView *favoriteTable;
@end
