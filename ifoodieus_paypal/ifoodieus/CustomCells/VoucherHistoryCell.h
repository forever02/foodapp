//
//  VoucherHistoryCell.h
//  ifoodieus
//
//  Created by dev on 5/18/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VoucherHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgVoucher;
@property (weak, nonatomic) IBOutlet UILabel *lblVoucherCount
;
@property (weak, nonatomic) IBOutlet UILabel *lblVoucherDate;

@end
