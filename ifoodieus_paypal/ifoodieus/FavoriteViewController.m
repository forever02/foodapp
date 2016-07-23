//
//  FavoriteViewController.m
//  ifoodieus
//
//  Created by dev on 5/25/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "FavoriteViewController.h"
#import "SearchViewController.h"
#import "RestaurantCell.h"
#import "RestaurantTermsViewController.h"
#import "VoucherViewController.h"
#import "AccountViewController.h"
#import "AboutUSViewContoller.h"
#import "RestaurantInfoViewController.h"
#import "ChooseCity.h"
#import "MapViewController.h"
#import "common.h"
#import "HttpApi.h"
#import "RestaurantItem.h"
#import <UIImageView+WebCache.h>

NSMutableArray* favoriteList;
@interface FavoriteViewController ()

@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initValues];
    [self initViews];
    [self getdata];
    [self.favoriteTable setAllowsSelection:YES];
    [[common sharedCommon] showSpinner:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//set initial view
-(void)initValues{
    favoriteList = [[NSMutableArray alloc] init];
    if([common sharedCommon].dataLoaded){
        [self.txt_top_name setHidden:YES];
    }else{
        [self.txt_top_name setHidden:NO];
        [self.txt_top_name setText:[common sharedCommon].selectedCityName];
    }
}
-(void)getdata{
    NSString *cityId = [common sharedCommon].selectedCityId;
    NSString *latitude = [NSString stringWithFormat:@"%f", [common sharedCommon].myLatitude ];
    NSString *longitude = [NSString stringWithFormat:@"%f", [common sharedCommon].myLongitude];
    [[HttpApi sharedInstance] getFavoriteList:[common sharedCommon].uniqueId Longitude:longitude Latitude:latitude City:cityId
                                    Complete:^(NSString *responseObject){
                                        NSDictionary *dicResponse = (NSDictionary *)responseObject;
                                        if([[dicResponse objectForKey:@"msg"] isEqualToString:@"Success"]){
                                            [self getRestaurantsWithString:responseObject];
                                        }else{
                                            [favoriteList removeAllObjects];
                                            [self.favoriteTable reloadData];
                                            [[common sharedCommon] hiddenSpinner:self.view];
                                        }
                                    } Failed:^(NSString *strError) {
                                        
                                        [[common sharedCommon] hiddenSpinner:self.view];
                                                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"iFoodieus" message:@"No network access please try again!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                [alert show];
                                    }];
}
-(void)initViews{
    UIImage *img1 = [[common sharedCommon].storeImages valueForKey:@"title"];
    [self.imt_top_background setImage:img1];
    UIImage *img2 = [[common sharedCommon].storeImages valueForKey:@"back"];
    [self.img_top_info setImage:img2 forState:UIControlStateNormal];
    UIImage *img3 = [[common sharedCommon].storeImages valueForKey:@"global"];
    [self.img_top_global setImage:img3 forState:UIControlStateNormal];
}

-(void)getRestaurantsWithString:(NSString *) value{
    NSDictionary *dicResponse = (NSDictionary *)value;
    NSString *status = [dicResponse objectForKey:@"msg"];
    if([status isEqualToString:@"Success"]){
        [favoriteList removeAllObjects];
        NSArray *tmpList = (NSArray*)[dicResponse objectForKey:@"data"];
        for(int nIndex = 0; nIndex < tmpList.count; nIndex++){
            RestaurantItem *restItem = [[RestaurantItem alloc] initWithDictionary:[tmpList objectAtIndex:nIndex]];
            [favoriteList addObject:restItem];
            [self.favoriteTable reloadData];
        }
        [[common sharedCommon] hiddenSpinner:self.view];
    }else{
        [[common sharedCommon] hiddenSpinner:self.view];
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"iFoodie" message:@"No network access please try again!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //        [alert show];
    }
}

//actions
- (IBAction)gotoHelp:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChooseCity *vc = [sb instantiateViewControllerWithIdentifier:@"ChooseCityIdentifier"];
    [self presentViewController:vc animated:NO completion:NULL];
    //    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //    RestaurantTermsViewController *vc = [sb instantiateViewControllerWithIdentifier:@"RestaurantTermsViewControllerIdentity"];
    //    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    ////    vc.mode = self.mode;
    //    [self presentViewController:vc animated:NO completion:NULL];
}
- (IBAction)gotoGlobal:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AboutUSViewContoller *vc = [sb instantiateViewControllerWithIdentifier:@"AboutUSViewContollerIdentity"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //    vc.mode = self.mode;
    [self presentViewController:vc animated:NO completion:NULL];
    
}
- (IBAction)BottomNearbyClick:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MapViewControllerIdentity"];
    //    vc.mode = self.mode;
    [self presentViewController:vc animated:NO completion:NULL];
}
- (IBAction)BottomVoucherClick:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VoucherViewController *vc = [sb instantiateViewControllerWithIdentifier:@"VoucherViewControllerIdentity"];
    //    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //    vc.mode = self.mode;
    [self presentViewController:vc animated:NO completion:NULL];
}
- (IBAction)BottomSearchClick:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SearchViewControllerIdentity"];
    //    vc.mode = self.mode;
    [self presentViewController:vc animated:NO completion:NULL];
}
- (IBAction)BottomFavoritesClick:(id)sender {
}
- (IBAction)BottomAccountClick:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AccountViewController *vc = [sb instantiateViewControllerWithIdentifier:@"AccountViewControllerIdentity"];
    //    vc.mode = self.mode;
    [self presentViewController:vc animated:NO completion:NULL];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}



//#pragma mark - Table view data source
#pragma mark UITableViewDataSource methods

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [favoriteList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        RestaurantCell *cell = nil;
        static NSString *cellRowIdentifier = @"RestaurantTableCell1";
        cell = [tableView dequeueReusableCellWithIdentifier:cellRowIdentifier forIndexPath:indexPath];
        
        if (cell == nil){
            cell = [[RestaurantCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellRowIdentifier];
        }
        RestaurantItem *item = favoriteList[indexPath.row];
        if([item.image containsString:@"jpeg"] || [item.image containsString:@"png"]){
            [cell.img_restaurant sd_setImageWithURL:[NSURL URLWithString:item.image]];
        }else{
            [cell.img_restaurant setImage:[UIImage imageNamed:@"restaurant_tmp.png"]];
        }
        //    [cell.img_restaurant setImage:[UIImage imageNamed:item.image]];
        [cell.txt_Name setText:item.productName];
        [cell.txt_Address setText:item.address];
        [cell.txt_Category setText:item.cousine];
        //    NSInteger dis = [item.distance integerValue];
        //    float distance = dis/1000;
        //    [cell.txt_Distance setText:[NSString stringWithFormat:@"%.2f",distance]];
        [cell.txt_Distance setText:item.distance];
    [cell.bttfav setTag:indexPath.row];
        [cell setStarRating:[item.rating intValue]];
    
        return cell;
}

//#pragma mark - UITableViewDelegate Implementation
#pragma mark UITableViewDelegate methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RestaurantItem *item = favoriteList[indexPath.row];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RestaurantInfoViewController *vc = [sb instantiateViewControllerWithIdentifier:@"RestaurantInfoViewControllerIdentity"];
//    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    vc.restaurantItem = item;
    [self presentViewController:vc animated:NO completion:NULL];
}
- (IBAction)clickFavoriteMark:(id)sender {
    [[common sharedCommon] showSpinner:self.view];
    NSInteger a = [sender tag];
    RestaurantItem *item = favoriteList[a];
    [[HttpApi sharedInstance] setFavourite:[common sharedCommon].uniqueId ProductId:item.productId Status:@"0" Complete:^(NSString *responseObject){
    NSDictionary *dicResponse = (NSDictionary *)responseObject;
    if([[dicResponse objectForKey:@"msg"] isEqualToString:@"Success"]){        
        [self getdata];
    }
}Failed:^(NSString *strError){
    
}];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
