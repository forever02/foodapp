//
//  ChooseCity.h
//  ifoodieus
//
//  Created by dev on 5/17/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ChooseCity : UIViewController<UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    bool bdebug;
    bool isLoading;
}
@property (weak, nonatomic) IBOutlet UITableView *cityTable;
//@property (nonatomic, retain) CLLocationManager *locationManager;

@end
