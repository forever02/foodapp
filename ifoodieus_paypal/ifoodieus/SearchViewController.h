//
//  SearchViewController.h
//  ifoodieus
//
//  Created by dev on 5/17/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"

@interface SearchViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imt_top_background;
@property (weak, nonatomic) IBOutlet UIButton *img_top_info;
@property (weak, nonatomic) IBOutlet UILabel *txt_top_name;
@property (weak, nonatomic) IBOutlet UIButton *img_top_global;
@property (weak, nonatomic) IBOutlet UITextField *txt_search;
@property (weak, nonatomic) IBOutlet UIButton *btt_name;
@property (weak, nonatomic) IBOutlet UIButton *btt_cuisine;
@property (weak, nonatomic) IBOutlet UIButton *btt_location;
@property (weak, nonatomic) IBOutlet UIButton *btt_distance;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIView *searchBarView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *nothingFound;
@property (weak, nonatomic) IBOutlet UIView *cityView;

@property (weak, nonatomic) IBOutlet UITableView *restaurantTable;
@property (weak, nonatomic) IBOutlet UITableView *cityTable;
@property NSMutableArray* citiList;
@end
