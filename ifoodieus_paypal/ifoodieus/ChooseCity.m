//
//  ChooseCity.m
//  ifoodieus
//
//  Created by dev on 5/17/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "ChooseCity.h"
#import "SearchViewController.h"
#import "CityCell.h"
#import "HttpApi.h"
#import "CityItem.h"
#import <UIImageView+WebCache.h>
#import "MapViewController.h"
#import "common.h"
#import "VoucherViewController.h"

NSMutableArray* citiList;

@implementation ChooseCity

-(BOOL)prefersStatusBarHidden{
    return YES;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    bdebug = false;isLoading = false;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    [common sharedCommon].myLongitude = 40.8222;
    [common sharedCommon].myLatitude = -73.854;
}

#pragma mark - CLLocatinManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"iFoodieus" message:@"Failed to get your Geo Location!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [common sharedCommon].myLongitude = newLocation.coordinate.longitude;
    [common sharedCommon].myLatitude = newLocation.coordinate.latitude;
}
//iOS 6
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    [common sharedCommon].myLongitude = location.coordinate.longitude;
    [common sharedCommon].myLatitude = location.coordinate.latitude;
}



-(void)viewDidAppear:(BOOL)animated{
//    [self initValues];
    //    [self initViews];
    [[common sharedCommon] showSpinner:self.view];
    citiList = [[NSMutableArray alloc] init];
    [common sharedCommon].storeImages = [[NSMutableDictionary alloc] init];
    [self getData];
}

-(void)getData{
    [[HttpApi sharedInstance] getCitis:^(NSString *responseObject) {
        [self getCitisWithString:responseObject];
    } Failed:^(NSString *strError) {
        //
        [[common sharedCommon] hiddenSpinner:self.view];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"iFoodieus" message:@"No network access please try again!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
-(void)getCitisWithString:(NSString *) value{
    NSDictionary *dicResponse = (NSDictionary *)value;
    NSString *status = [dicResponse objectForKey:@"msg"];
    if([status isEqualToString:@"Success"]){
        [citiList removeAllObjects];
        NSArray *tmpList = (NSArray*)[dicResponse objectForKey:@"data"];
        for(int nIndex = 0; nIndex < tmpList.count; nIndex++){
            CityItem *cityItem = [[CityItem alloc] initWithDictionary:[tmpList objectAtIndex:nIndex]];
            [citiList addObject:cityItem];
//            if(nIndex == tmpList.count -1){
//                CityItem *cityItem = [[CityItem alloc] initWithDictionary:[tmpList objectAtIndex:nIndex]];
//                [citiList addObject:cityItem];
//            }
        }
        [self.cityTable reloadData];
        [common sharedCommon].cityArray = citiList;
        [[common sharedCommon] hiddenSpinner:self.view];
    }else{
        [[common sharedCommon] hiddenSpinner:self.view];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"iFoodieus" message:@"No network access please try again!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [self getData];
    }
}


//#pragma mark - Table view data source
#pragma mark UITableViewDataSource methods

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = citiList.count;
    if(count % 2 == 0){
        return count/2;
    }else{
        return (count+1)/2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityCell *cell = nil;
    static NSString *cellRowIdentifier = @"CityTableViewCell";
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
//actions
- (IBAction)chooseGeolocation:(id)sender {
//    
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    VoucherViewController *vc = [sb instantiateViewControllerWithIdentifier:@"VoucherViewControllerIdentity"];
//    //    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    //    vc.mode = self.mode;
//    [self presentViewController:vc animated:NO completion:NULL];
    
    [[common sharedCommon] showSpinner:self.view];
    NSString *latitude = [NSString stringWithFormat:@"%f",[common sharedCommon].myLatitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",[common sharedCommon].myLongitude];
    
    [[HttpApi sharedInstance] getRestaurantsWithLocation:[common sharedCommon].uniqueId Longitude:longitude Latitude:latitude
                                                Complete:^(NSString *responseObject){
                                                    NSDictionary *dicResponse = (NSDictionary *)responseObject;
                                                    [self getCityDataFromGeolocation:dicResponse];
                                                } Failed:^(NSString *strError) {
                                                    [[common sharedCommon] hiddenSpinner:self.view];
                                                }];
   
}

-(void)getCityDataFromGeolocation:(NSDictionary *)data{
    NSArray *tmpList = (NSArray*)[data objectForKey:@"data"];
    if(tmpList.count > 0){
        NSString *_cityid = (NSString *)[tmpList[0] objectForKey:@"in_category_id"];
        NSString *_cityName = (NSString *)[tmpList[0] objectForKey:@"st_category_name"];
        
        [[common sharedCommon] showSpinner:self.view];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SearchViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SearchViewControllerIdentity"];
        
        UIImage *img1 = [UIImage imageNamed:@"top_indi.png"];
        [common sharedCommon].dataLoaded = false;
        [common sharedCommon].selectedCityName = _cityName;
        
        UIImage *img2 = [UIImage imageNamed:@"global_indi.png"];
        UIImage *img3 = [UIImage imageNamed:@"back_indi.png"];
        UIImage *img4 = [UIImage imageNamed:@"people_normal_indi.png"];
        [common sharedCommon].selectedCityId = _cityid;
        [[common sharedCommon].storeImages setObject:img1 forKey:@"title"];
        [[common sharedCommon].storeImages setObject:img2 forKey:@"global"];
        [[common sharedCommon].storeImages setObject:img3 forKey:@"back"];
        [[common sharedCommon].storeImages setObject:img4 forKey:@"group"];
        [[common sharedCommon] hiddenSpinner:self.view];
        [self presentViewController:vc animated:NO completion:NULL];
    }else{
        [[common sharedCommon] hiddenSpinner:self.view];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"iFoodieus" message:@"No network access please try again!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    }
}

- (IBAction)chooseRestaurant:(id)sender {
    if(!isLoading)
        isLoading = true;
    else
        return;
    [[common sharedCommon] showSpinner:self.view];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SearchViewControllerIdentity"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    NSInteger a = [sender tag];
    CityItem *item = citiList[a];
    UIImage *img1, *img2, *img3, *img4;
    if(bdebug){
        [common sharedCommon].dataLoaded = false;
        [common sharedCommon].selectedCityName = item.cityName;
        img1 = [UIImage imageNamed:@"top_indi.png"];
        img2 = [UIImage imageNamed:@"global_indi.png"];
        img3 = [UIImage imageNamed:@"back_indi.png"];
        img4 = [UIImage imageNamed:@"people_normal_indi.png"];
    }else{
        NSURL *url1 =[NSURL URLWithString:item.cityTitleImage];
        NSData *data1 = [NSData dataWithContentsOfURL:url1];
        img1 = [[UIImage alloc] initWithData:data1];
        if(img1 == nil){
            img1 = [UIImage imageNamed:@"top_indi.png"];
            [common sharedCommon].dataLoaded = false;
            [common sharedCommon].selectedCityName = item.cityName;
        }else{
            [common sharedCommon].dataLoaded = true;
        }
        data1 = nil;
        NSURL *url2 =[NSURL URLWithString:item.cityGlobalImage];
        data1 = [NSData dataWithContentsOfURL:url2];
        img2 = [[UIImage alloc] initWithData:data1];
        if(img2 == nil){
            img2 = [UIImage imageNamed:@"global_indi.png"];
        }
        data1 = nil;
        
        NSURL *url3 =[NSURL URLWithString:item.cityBackImage];
        data1 = [NSData dataWithContentsOfURL:url3];
        img3 = [[UIImage alloc] initWithData:data1];
        if(img3 == nil){
            img3 = [UIImage imageNamed:@"back_indi.png"];
        }
        
        data1 = nil;
        NSURL *url4 =[NSURL URLWithString:item.cityGroupImage];
        data1 = [NSData dataWithContentsOfURL:url4];
        img4 = [[UIImage alloc] initWithData:data1];
        if(img4 == nil){
            img4 = [UIImage imageNamed:@"people_normal_indi.png"];
        }

    }
    [common sharedCommon].selectedCityId = item.cityId;
    [[common sharedCommon].storeImages setObject:img1 forKey:@"title"];
    [[common sharedCommon].storeImages setObject:img2 forKey:@"global"];
    [[common sharedCommon].storeImages setObject:img3 forKey:@"back"];
    [[common sharedCommon].storeImages setObject:img4 forKey:@"group"];
    vc.citiList = citiList;
    [[common sharedCommon] hiddenSpinner:self.view];
    [self presentViewController:vc animated:NO completion:NULL];
    
}

@end
