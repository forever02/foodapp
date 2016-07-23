//
//  SearchViewController.m
//  ifoodieus
//
//  Created by dev on 5/17/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "SearchViewController.h"
#import "RestaurantCell.h"
#import "RestaurantTermsViewController.h"
#import "VoucherViewController.h"
#import "AccountViewController.h"
#import "AboutUSViewContoller.h"
#import "RestaurantInfoViewController.h"
#import "FavoriteViewController.h"
#import "ChooseCity.h"
#import "MapViewController.h"
#import "common.h"
#import "HttpApi.h"
#import "RestaurantItem.h"
#import <UIImageView+WebCache.h>
#import "CityCell.h"
#import "CityItem.h"


NSMutableArray* restaurantList;
@implementation SearchViewController{
    BOOL isShowingSearchField;
}

@synthesize restaurantTable;
@synthesize cityTable;
@synthesize citiList;

-(void)viewDidLoad{
    [super viewDidLoad];
}
-(void)viewDidAppear:(BOOL)animated{
    [self.nothingFound setHidden:YES];
    [self initValues];
    [self initViews];
    [self.restaurantTable setAllowsSelection:YES];
    [[common sharedCommon] showSpinner:self.view];
}
//set initial view
-(void)initValues{
    restaurantList = [[NSMutableArray alloc] init];
    NSString *cityId = [common sharedCommon].selectedCityId;
    
    NSString *latitude = [NSString stringWithFormat:@"%f", [common sharedCommon].myLatitude ];
    NSString *longitude = [NSString stringWithFormat:@"%f", [common sharedCommon].myLongitude];
    
    [[HttpApi sharedInstance] getRestaurants:cityId SearchStr:@"" Longitude:longitude Latitude:latitude
        Complete:^(NSString *responseObject){
            [self getRestaurantsWithString:responseObject];
            [self.nothingFound setHidden:YES];
        } Failed:^(NSString *strError) {
            [self.nothingFound setHidden:NO];
            [[common sharedCommon] hiddenSpinner:self.view];
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"iFoodie" message:@"No network access please try again!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
    }];
}
-(void)initViews{
    if([common sharedCommon].dataLoaded){
        [self.txt_top_name setHidden:YES];
    }else{
        [self.txt_top_name setHidden:NO];
        [self.txt_top_name setText:[common sharedCommon].selectedCityName];
    }
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
        restaurantList = [[NSMutableArray alloc] init];
        NSArray *tmpList = (NSArray*)[dicResponse objectForKey:@"data"];
        for(int nIndex = 0; nIndex < tmpList.count; nIndex++){
            RestaurantItem *restItem = [[RestaurantItem alloc] initWithDictionary:[tmpList objectAtIndex:nIndex]];
            [restaurantList addObject:restItem];
        }
        [common sharedCommon].restaurantArray = restaurantList;
        [[common sharedCommon] hiddenSpinner:self.view];
        [self clickName:nil];
    }else{
        [[common sharedCommon] hiddenSpinner:self.view];
        [self.nothingFound setHidden:NO];
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
- (IBAction)startSearch:(id)sender {
    if(isShowingSearchField)
        [self closeSrchView:nil];
    [[common sharedCommon] showSpinner:self.view];
    NSString *searchText = self.txt_search.text;
    NSString *cityId = [common sharedCommon].selectedCityId;
    NSString *latitude = @"40.8222";
    NSString *longitude = @"-73.854";
    
    [[HttpApi sharedInstance] getRestaurants:cityId SearchStr:searchText Longitude:longitude Latitude:latitude
                                    Complete:^(NSString *responseObject){
                                        [self getRestaurantsWithString:responseObject];
                                        [self.nothingFound setHidden:YES];
                                    } Failed:^(NSString *strError) {
                                        [self showSearchView];
                                        [self.nothingFound setHidden:NO];
                                        [self.txt_search resignFirstResponder];
                                        [[common sharedCommon] hiddenSpinner:self.view];
                                    }];

}
- (IBAction)clickName:(id)sender {
    [[common sharedCommon] showSpinner:self.view];
    [self.btt_name setImage:[UIImage imageNamed:@"name2.png"] forState:UIControlStateNormal];
    [self.btt_cuisine setImage:[UIImage imageNamed:@"cui.png"] forState:UIControlStateNormal];
    [self.btt_location setImage:[UIImage imageNamed:@"loc1.png"] forState:UIControlStateNormal];
    [self.btt_distance setImage:[UIImage imageNamed:@"dis1.png"] forState:UIControlStateNormal];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"productName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sort];
    restaurantList = [restaurantList sortedArrayUsingDescriptors:sortDescriptors];
    [self.restaurantTable reloadData];
    [[common sharedCommon] hiddenSpinner:self.view];
    
}
- (IBAction)clickCuisine:(id)sender {
    [[common sharedCommon] showSpinner:self.view];
    [self.btt_name setImage:[UIImage imageNamed:@"name1.png"] forState:UIControlStateNormal];
    [self.btt_cuisine setImage:[UIImage imageNamed:@"cui2.png"] forState:UIControlStateNormal];
    [self.btt_location setImage:[UIImage imageNamed:@"loc1.png"] forState:UIControlStateNormal];
    [self.btt_distance setImage:[UIImage imageNamed:@"dis1.png"] forState:UIControlStateNormal];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"cousine" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sort];
    restaurantList = [restaurantList sortedArrayUsingDescriptors:sortDescriptors];
    [self.restaurantTable reloadData];
    [[common sharedCommon] hiddenSpinner:self.view];
}
- (IBAction)clickLocation:(id)sender {
    [[common sharedCommon] showSpinner:self.view];
    [self.btt_name setImage:[UIImage imageNamed:@"name1.png"] forState:UIControlStateNormal];
    [self.btt_cuisine setImage:[UIImage imageNamed:@"cui.png"] forState:UIControlStateNormal];
    [self.btt_location setImage:[UIImage imageNamed:@"loc2.png"] forState:UIControlStateNormal];
    [self.btt_distance setImage:[UIImage imageNamed:@"dis1.png"] forState:UIControlStateNormal];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"address" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sort];
    restaurantList = [restaurantList sortedArrayUsingDescriptors:sortDescriptors];
    [self.restaurantTable reloadData];
    [[common sharedCommon] hiddenSpinner:self.view];
}
- (IBAction)clickDistance:(id)sender {
    [[common sharedCommon] showSpinner:self.view];
    [self.btt_name setImage:[UIImage imageNamed:@"name1.png"] forState:UIControlStateNormal];
    [self.btt_cuisine setImage:[UIImage imageNamed:@"cui.png"] forState:UIControlStateNormal];
    [self.btt_location setImage:[UIImage imageNamed:@"loc1.png"] forState:UIControlStateNormal];
    [self.btt_distance setImage:[UIImage imageNamed:@"dis2.png"] forState:UIControlStateNormal];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sort];
    restaurantList = [restaurantList sortedArrayUsingDescriptors:sortDescriptors];
    [self.restaurantTable reloadData];
    [[common sharedCommon] hiddenSpinner:self.view];
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
}
- (IBAction)BottomFavoritesClick:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FavoriteViewController *vc = [sb instantiateViewControllerWithIdentifier:@"FavoriteViewControllerIdentity"];
    [self presentViewController:vc animated:NO completion:NULL];
}
- (IBAction)BottomAccountClick:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AccountViewController *vc = [sb instantiateViewControllerWithIdentifier:@"AccountViewControllerIdentity"];
//    vc.mode = self.mode;
    [self presentViewController:vc animated:NO completion:NULL];
}
- (IBAction)clickHead:(id)sender {
    if(isShowingSearchField)
        [self closeSrchView:nil];
    [UIView beginAnimations:@"slideDown" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.4f];
    [UIView setAnimationDelegate:(id)self];
    
    [self.cityView setCenter:CGPointMake(self.cityView.frame.size.width/2, self.topView.frame.size.height + self.cityView.frame.size.height/2)];
    [UIView commitAnimations];
    citiList = [common sharedCommon].cityArray;
    [cityTable reloadData];
}
- (IBAction)clickClose:(id)sender {
    [UIView beginAnimations:@"slideUp" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.4f];
    [UIView setAnimationDelegate:(id)self];
    [UIView setAnimationDidStopSelector:@selector(hideSearchViewSecondPart)];
    
    [self.cityView setCenter:CGPointMake(self.cityView.frame.size.width/2, -self.cityView.frame.size.height/2)];
    
    [UIView commitAnimations];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
//textField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self showSearchView];
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self.txt_search resignFirstResponder];
    [self startSearch:nil];
    return YES;
}
- (void)showSearchView {
    if(isShowingSearchField)
        return;
    
    [self.txt_search becomeFirstResponder];
    [UIView beginAnimations:@"slideDown" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.4f];
    [UIView setAnimationDelegate:(id)self];
    [UIView setAnimationDidStopSelector:@selector(showSearchViewSecondPart)];
    
    [self.txt_search becomeFirstResponder];
    [self.searchView setCenter:CGPointMake(self.searchView.frame.size.width/2, self.topView.frame.size.height + self.searchBarView.frame.size.height/2)];
//    [_shadowImage setAlpha:0.25];
//    [self.searchBarBottomShadow setAlpha:0.0];
    
    [UIView commitAnimations];
}

- (void)showSearchViewSecondPart
{
    [UIView beginAnimations:@"slideDown2" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.25f];
    
    [self.searchView setCenter:CGPointMake(self.searchView.frame.size.width/2, self.searchView.frame.size.height/2 + self.topView.frame.size.height)];
    [self.searchBarView setCenter:CGPointMake(self.searchBarView.frame.size.width/2, self.searchView.frame.size.height/2 + self.topView.frame.size.height+8)];
//    [_shadowImage setAlpha:0.5];
    
    [UIView commitAnimations];
    isShowingSearchField = YES;
}

- (IBAction)closeSrchView:(id)sender {
    [self.txt_search resignFirstResponder];
    NSString *str = [self.txt_search.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([str length]<1) {
//        searching = FALSE;
//        [searchTable reloadData];
    }
    [UIView beginAnimations:@"slideUp" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.25f];
    [UIView setAnimationDelegate:(id)self];
    [UIView setAnimationDidStopSelector:@selector(hideSearchViewSecondPart)];
    
    [self.searchView setCenter:CGPointMake(self.searchView.frame.size.width/2, self.topView.frame.size.height + self.searchBarView.frame.size.height/2)];
    [self.searchBarView setCenter:CGPointMake(self.searchBarView.frame.size.width/2, self.topView.frame.size.height + self.searchBarView.frame.size.height/2)];
//    [_shadowImage setAlpha:0.25];
    
    [UIView commitAnimations];
    
    self.restaurantTable.hidden = FALSE;
//    self.noResultsImg.hidden = TRUE;
}

- (void)hideSearchViewSecondPart
{
    [UIView beginAnimations:@"slideUp2" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationDelegate:(id)self];
    [UIView setAnimationDidStopSelector:@selector(setShadowImageHidden)];
    
    [self.searchView setCenter:CGPointMake(self.searchView.frame.size.width/2, -self.searchView.frame.size.height)];
//    [self.searchBarBottomShadow setAlpha:1.0];
//    [_shadowImage setAlpha:0.0];
    
    [UIView commitAnimations];
    isShowingSearchField = NO;
}

//#pragma mark - Table view data source
#pragma mark UITableViewDataSource methods

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView.tag == 101)
        return [restaurantList count];
    else if(tableView.tag == 201){
        NSInteger count = citiList.count;
        if(count % 2 == 0){
            return count/2;
        }else{
            return (count+1)/2;
        }
    }else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 101){
        
        RestaurantCell *cell = nil;
        static NSString *cellRowIdentifier = @"RestaurantTableCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellRowIdentifier forIndexPath:indexPath];
        
        if (cell == nil){
            cell = [[RestaurantCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellRowIdentifier];
        }
        RestaurantItem *item = restaurantList[indexPath.row];
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
        [cell setStarRating:[item.rating intValue]];
        return cell;
    }else{
        CityCell *cell = nil;
        static NSString *cellRowIdentifier = @"CityTableViewCell1";
        cell = [tableView dequeueReusableCellWithIdentifier:cellRowIdentifier forIndexPath:indexPath];
        
        if (cell == nil){
            cell = [[CityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellRowIdentifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if(citiList.count == 2*indexPath.row+1){
            CityItem *item1 = citiList[indexPath.row * 2];
            CGPoint _point = cell.imgCity1.frame.origin;
            CGSize _size = cell.imgCity1.frame.size;
            CGSize _sizeCell = cell.frame.size;
            [cell.imgCity1 setFrame:CGRectMake((_sizeCell.width-_size.width)/2,_point.y,_size.width,_size.height)];
            [cell.imgCity1 sd_setImageWithURL:[NSURL URLWithString:item1.cityImage]];
            [cell.imgCity2 setHidden:YES];
            
            [cell.bttCity1 setTag: indexPath.row * 2 + 1];
        }else{
            CityItem *item1 = citiList[indexPath.row * 2];
            [cell.imgCity1 sd_setImageWithURL:[NSURL URLWithString:item1.cityImage]];
            [cell.bttCity1 setTag: indexPath.row * 2];
            CityItem *item2 = citiList[indexPath.row * 2 + 1];
            [cell.imgCity2 sd_setImageWithURL:[NSURL URLWithString:item2.cityImage]];
            [cell.bttCity2 setTag: indexPath.row * 2 + 1];
        }
        return cell;

    }
}

//#pragma mark - UITableViewDelegate Implementation
#pragma mark UITableViewDelegate methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RestaurantItem *item = restaurantList[indexPath.row];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RestaurantInfoViewController *vc = [sb instantiateViewControllerWithIdentifier:@"RestaurantInfoViewControllerIdentity"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    vc.restaurantItem = item;
    [self presentViewController:vc animated:NO completion:NULL];
}
//
//-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    return nil;
//}
#pragma mark UITableViewDataSource methods
- (IBAction)chooseRestaurant:(id)sender {
    [self clickClose:nil];
    [[common sharedCommon] showSpinner:self.view];
    NSInteger a = [sender tag];
    CityItem *item = citiList[a];
    NSURL *url1 =[NSURL URLWithString:item.cityTitleImage];
    NSData *data1 = [NSData dataWithContentsOfURL:url1];
    UIImage *img1 = [[UIImage alloc] initWithData:data1];
    if(img1 == nil){
        img1 = [UIImage imageNamed:@"top_indi.png"];
        [common sharedCommon].selectedCityName = item.cityName;
        [common sharedCommon].dataLoaded = false;
    }else{
        [common sharedCommon].dataLoaded = true;
    }
    
    NSURL *url2 =[NSURL URLWithString:item.cityGlobalImage];
    NSData *data2 = [NSData dataWithContentsOfURL:url2];
    UIImage *img2 = [[UIImage alloc] initWithData:data2];
    if(img2 == nil){
        img2 = [UIImage imageNamed:@"global_indi.png"];
    }
    
    NSURL *url3 =[NSURL URLWithString:item.cityBackImage];
    NSData *data3 = [NSData dataWithContentsOfURL:url3];
    UIImage *img3 = [[UIImage alloc] initWithData:data3];
    if(img3 == nil){
        img3 = [UIImage imageNamed:@"back_indi.png"];
    }
    
    NSURL *url4 =[NSURL URLWithString:item.cityGroupImage];
    NSData *data4 = [NSData dataWithContentsOfURL:url4];
    UIImage *img4 = [[UIImage alloc] initWithData:data4];
    if(img4 == nil){
        img4 = [UIImage imageNamed:@"people_normal_indi.png"];
    }

    [common sharedCommon].selectedCityId = item.cityId;
    [[common sharedCommon].storeImages setObject:img1 forKey:@"title"];
    [[common sharedCommon].storeImages setObject:img2 forKey:@"global"];
    [[common sharedCommon].storeImages setObject:img3 forKey:@"back"];
    [[common sharedCommon].storeImages setObject:img4 forKey:@"group"];
    [self.nothingFound setHidden:YES];
    [self initValues];
    [self initViews];
    [self.restaurantTable setAllowsSelection:YES];
}
@end
