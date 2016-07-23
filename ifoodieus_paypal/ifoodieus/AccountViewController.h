//
//  AccountViewController.h
//  ifoodieus
//
//  Created by dev on 5/18/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface AccountViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>{
    
    MFMailComposeViewController *mailComposer;
}

@property (weak, nonatomic) IBOutlet UIImageView *imt_top_background;
@property (weak, nonatomic) IBOutlet UIButton *btt_top_info;
@property (weak, nonatomic) IBOutlet UILabel *txt_top_name;
@property (weak, nonatomic) IBOutlet UIButton *btt_top_global;
@property (weak, nonatomic) IBOutlet UILabel *txt_Title;
@property (weak, nonatomic) IBOutlet UIButton *btt_account;
@property (weak, nonatomic) IBOutlet UIButton *btt_history;
@property (weak, nonatomic) IBOutlet UIButton *btt_reedem;
@property (weak, nonatomic) IBOutlet UIButton *btt_expired;
@property (weak, nonatomic) IBOutlet UILabel *lblhistory_help;

@property (weak, nonatomic) IBOutlet UIView *viewStep1;
@property (weak, nonatomic) IBOutlet UIView *viewStep2;

@property (weak, nonatomic) IBOutlet UILabel *txt_Remaining;
@property (weak, nonatomic) IBOutlet UILabel *txt_Used;
@property (weak, nonatomic) IBOutlet UILabel *txt_Savings;


@property (weak, nonatomic) IBOutlet UITableView *voucherTable;
@property NSMutableArray *dataArray;
//AccountViewControllerIdentity
@end
