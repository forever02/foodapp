//
//  MapViewController.m
//  ifoodieus
//
//  Created by dev on 5/19/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "MapViewController.h"
#import "VoucherViewController.h"
#import "SearchViewController.h"
#import "AccountViewController.h"
#import "VoucherHistoryCell.h"
#import "ChooseCity.h"
#import "FavoriteViewController.h"
#import "common.h"
#import "RestaurantItem.h"
#import <UIImageView+WebCache.h>
#import "RestaurantInfoViewController.h"
#import "CityCell.h"
#import "CityItem.h"
#import "HttpApi.h"

@import GoogleMaps;

@interface MapViewController ()
@property (strong, nonatomic) GMSMapView *gmapView;
@end

@implementation MapViewController
@synthesize spinnerView;
@synthesize selectedNum;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[common sharedCommon] showSpinner:self.view];
    [self initViews];
    selectedNum = -1;
    [self initValues];
    self.txtSearch.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//set initial view
-(void)initValues{
    self.cityList = [[NSMutableArray alloc] init];
    self.restaurantList = [common sharedCommon].restaurantArray;
    for(int i = 0; i < self.restaurantList.count; i++){
        RestaurantItem *item = self.restaurantList[i];
        CGFloat lati = [item.latitude floatValue];
        CGFloat longi = [item.longitude floatValue];
        if(i == 0){
            [self changeCameraPosition:lati Longitude:longi];
        }
        [self createMaker:lati Longitude:longi Index:i];
    }
    [[common sharedCommon] hiddenSpinner:self.view];
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
    [self.img_top_back setImage:img2 forState:UIControlStateNormal];
}

-(void)getRestaurantData{
    NSString *cityId = [common sharedCommon].selectedCityId;
    NSString *latitude = [NSString stringWithFormat:@"%f",[common sharedCommon].myLatitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",[common sharedCommon].myLongitude];
    
    [[HttpApi sharedInstance] getRestaurants:cityId SearchStr:@"" Longitude:longitude Latitude:latitude
                                    Complete:^(NSString *responseObject){
                                        [self getRestaurantsWithString:responseObject];
                                    } Failed:^(NSString *strError) {
                                        
                                        [[common sharedCommon] hiddenSpinner:self.view];
                                    }];
}
-(void)getRestaurantsWithString:(NSString *) value{
    NSDictionary *dicResponse = (NSDictionary *)value;
    NSString *status = [dicResponse objectForKey:@"msg"];
    if([status isEqualToString:@"Success"]){
        self.restaurantList = [[NSMutableArray alloc] init];
        NSArray *tmpList = (NSArray*)[dicResponse objectForKey:@"data"];
        for(int nIndex = 0; nIndex < tmpList.count; nIndex++){
            RestaurantItem *restItem = [[RestaurantItem alloc] initWithDictionary:[tmpList objectAtIndex:nIndex]];
            [self.restaurantList addObject:restItem];
        }
        [common sharedCommon].restaurantArray = self.restaurantList;
        
        [self initViews];
        selectedNum = -1;
        [self initValues];
        [[common sharedCommon] hiddenSpinner:self.view];
    }else{
        [[common sharedCommon] hiddenSpinner:self.view];
    }
}


-(void)initLoadMapView{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.8222 longitude:-73.854 zoom:5];
    self.gmapView = [GMSMapView mapWithFrame:self.mapView.bounds camera:camera];
    self.gmapView.delegate = self;
}
-(void)changeCameraPosition:(CGFloat) latitude Longitude:(CGFloat) longitude
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:10];
    self.gmapView = [GMSMapView mapWithFrame:self.mapView.bounds camera:camera];
    self.gmapView.delegate = self;

}
-(void)createMaker:(CGFloat) latitude Longitude:(CGFloat) longitude Index:(int) index
{
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.icon = [UIImage imageNamed:@"map_pin.png"];
    marker.position = CLLocationCoordinate2DMake(latitude, longitude);
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = self.gmapView;
    marker.userData = [NSString stringWithFormat:@"%d",index];
    [self.mapView addSubview:self.gmapView];
    
}

-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    int index = [marker.userData intValue];
    if(selectedNum == index){
        [self hiddenSnipper];
    }else{
        selectedNum = index;
        CGPoint point = [mapView.projection pointForCoordinate:marker.position];
        [self controllSnipper:index Position:point];
    }
    return YES;
}
-(void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    selectedNum = -1;
    [self hiddenSnipper];
}
-(void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position
{
    selectedNum = -1;
    [self hiddenSnipper];
}

-(UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker
{
    return nil;
}

-(void)controllSnipper:(int) index Position:(CGPoint) point
{
//    spinnerView.frame.origin.y = point.y - 30;
    [spinnerView setFrame:CGRectMake(spinnerView.frame.origin.x, point.y - 70, spinnerView.frame.size.width, spinnerView.frame.size.height)];
    [self.imgArrow setFrame:CGRectMake(point.x-25, self.imgArrow.frame.origin.y, self.imgArrow.frame.size.width, self.imgArrow.frame.size.height)];
    [spinnerView setHidden:NO];
    RestaurantItem *item = self.restaurantList[index];
    [self.txtName setText:item.productName];
    [self.txtAddress setText: item.address];
    [self.txtCuisine setText: item.cousine];
    [self.txtMiles setText: item.distance];
    [self setStarRating:[item.rating intValue]];
    
    if([item.image containsString:@"jpeg"] || [item.image containsString:@"png"]){
        [self.imgRestaurant sd_setImageWithURL:[NSURL URLWithString:item.image]];
    }else{
        [self.imgRestaurant setImage:[UIImage imageNamed:@"restaurant_tmp.png"]];
    }
}
-(void)hiddenSnipper
{
    [spinnerView setHidden:YES];
}
-(void)setStarRating:(NSInteger) num{
    NSMutableArray *imgstarArr =  [[NSMutableArray alloc] initWithObjects:self.imgStar1,self.imgStar2,self.imgStar3,self.imgStar4,self.imgStar5, nil];
    for(int i = 0; i < imgstarArr.count; i++){
        if(i >= num){
            [imgstarArr[i] setHidden:YES];
        }else{
            [imgstarArr[i] setHidden:NO];
        }
    }
}
- (IBAction)spinnerClicked:(id)sender {
    if(selectedNum >= 0 && selectedNum < self.restaurantList.count){
        RestaurantItem *item = self.restaurantList[selectedNum];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RestaurantInfoViewController *vc = [sb instantiateViewControllerWithIdentifier:@"RestaurantInfoViewControllerIdentity"];
        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        vc.restaurantItem = item;
        [self presentViewController:vc animated:NO completion:NULL];
    }
}
- (IBAction)backClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChooseCity *vc = [sb instantiateViewControllerWithIdentifier:@"ChooseCityIdentifier"];
    [self presentViewController:vc animated:NO completion:NULL];
}

- (IBAction)NearbyClicked:(id)sender {
}
- (IBAction)SearchClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SearchViewControllerIdentity"];
//    vc.mode = self.mode;
    [self presentViewController:vc animated:NO completion:NULL];
}

- (IBAction)FavoriteClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FavoriteViewController *vc = [sb instantiateViewControllerWithIdentifier:@"FavoriteViewControllerIdentity"];
    [self presentViewController:vc animated:NO completion:NULL];
}
- (IBAction)AccountClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AccountViewController *vc = [sb instantiateViewControllerWithIdentifier:@"AccountViewControllerIdentity"];
//    vc.mode = self.mode;
    [self presentViewController:vc animated:NO completion:NULL];
}
- (IBAction)VoucherClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VoucherViewController *vc = [sb instantiateViewControllerWithIdentifier:@"VoucherViewControllerIdentity"];
    //    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    vc.mode = self.mode;
    [self presentViewController:vc animated:NO completion:NULL];
}
- (IBAction)viewSearchList:(id)sender {
    self.isSearchView = true;
    [UIView beginAnimations:@"slideDown" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.4f];
    [UIView setAnimationDelegate:(id)self];
    
    [self.SearchView setCenter:CGPointMake(self.SearchView.frame.size.width/2, self.topView.frame.size.height + self.SearchView.frame.size.height/2)];
    [UIView commitAnimations];
    [self.txtSearch becomeFirstResponder];
}
- (IBAction)closeSearchList:(id)sender {
    [self.txtSearch resignFirstResponder];
    [UIView beginAnimations:@"slideUp" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.4f];
    [UIView setAnimationDelegate:(id)self];
    
    [self.SearchView setCenter:CGPointMake(self.SearchView.frame.size.width/2, -self.SearchView.frame.size.height/2)];
    [UIView commitAnimations];
    self.isSearchView = false;
}
- (IBAction)startSearch:(id)sender {
    [self.txtSearch resignFirstResponder];
    
    if(self.isSearchView)
        [self closeSearchList:nil];
    [[common sharedCommon] showSpinner:self.view];
    NSString *searchText = self.txtSearch.text;
    NSString *cityId = [common sharedCommon].selectedCityId;
    NSString *latitude = [NSString stringWithFormat:@"%f", [common sharedCommon].myLatitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", [common sharedCommon].myLongitude];
    
    [[HttpApi sharedInstance] getRestaurants:cityId SearchStr:searchText Longitude:longitude Latitude:latitude
                                    Complete:^(NSString *responseObject){
                                        [self getRestaurantsWithString:responseObject];
                                        [self.nothingFound setHidden:YES];
                                    } Failed:^(NSString *strError) {
                                        
                                        [self viewSearchList:nil];
                                        [self.nothingFound setHidden:NO];
                                        [self.txtSearch resignFirstResponder];
                                        [[common sharedCommon] hiddenSpinner:self.view];
                                    }];

}

- (IBAction)closeCityList:(id)sender {
    [UIView beginAnimations:@"slideUp" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.4f];
    [UIView setAnimationDelegate:(id)self];
    
    [self.CityView setCenter:CGPointMake(self.CityView.frame.size.width/2, -self.CityView.frame.size.height/2)];
    [UIView commitAnimations];
}

- (IBAction)clickCitiList:(id)sender {
    if(self.isSearchView)
        [self closeSearchList:nil];
    [UIView beginAnimations:@"slideDown" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.4f];
    [UIView setAnimationDelegate:(id)self];
    
    [self.CityView setCenter:CGPointMake(self.CityView.frame.size.width/2, self.topView.frame.size.height + self.CityView.frame.size.height/2)];
    [UIView commitAnimations];
    self.cityList = [common sharedCommon].cityArray;
    [self.cityTable reloadData];

}


-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark UITableViewDataSource methods

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = self.cityList.count;
    if(count % 2 == 0){
        return count/2;
    }else{
        return (count+1)/2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityCell *cell = nil;
    static NSString *cellRowIdentifier = @"CityTableViewCell2";
    cell = [tableView dequeueReusableCellWithIdentifier:cellRowIdentifier forIndexPath:indexPath];
    
    if (cell == nil){
        cell = [[CityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellRowIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(self.cityList.count == 2*indexPath.row+1){
        CityItem *item1 = self.cityList[indexPath.row * 2];
        CGPoint _point = cell.imgCity1.frame.origin;
        CGSize _size = cell.imgCity1.frame.size;
        CGSize _sizeCell = cell.frame.size;
        [cell.imgCity1 setFrame:CGRectMake((_sizeCell.width-_size.width)/2,_point.y,_size.width,_size.height)];
        [cell.imgCity1 sd_setImageWithURL:[NSURL URLWithString:item1.cityImage]];
        [cell.imgCity2 setHidden:YES];
        
        [cell.bttCity1 setTag: indexPath.row * 2 + 1];
    }else{
        CityItem *item1 = self.cityList[indexPath.row * 2];
        [cell.imgCity1 sd_setImageWithURL:[NSURL URLWithString:item1.cityImage]];
        [cell.bttCity1 setTag: indexPath.row * 2];
        CityItem *item2 = self.cityList[indexPath.row * 2 + 1];
        [cell.imgCity2 sd_setImageWithURL:[NSURL URLWithString:item2.cityImage]];
        [cell.bttCity2 setTag: indexPath.row * 2 + 1];
    }
    return cell;

    
}

//#pragma mark - UITableViewDelegate Implementation
#pragma mark UITableViewDataSource methods
- (IBAction)chooseRestaurant:(id)sender {
    [[common sharedCommon] showSpinner:self.view];
    NSInteger a = [sender tag];
    CityItem *item = self.cityList[a];
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
    [self closeCityList:nil];
    [self getRestaurantData];
}
//textField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self.txtSearch resignFirstResponder];
    [self startSearch:nil];
    return YES;
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
