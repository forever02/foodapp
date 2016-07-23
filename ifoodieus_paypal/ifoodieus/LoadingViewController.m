//
//  LoadingViewController.m
//  ifoodieus
//
//  Created by dev on 5/17/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "LoadingViewController.h"
#import "AnimatedGIFImageSerialization.h"

@interface LoadingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *loadingani;

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadingAnimation];
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(onTick:) userInfo:nil repeats:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onTick:(NSTimer *)timer{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ChooseCityIdentifier"];
    [self presentViewController:vc animated:NO completion:NULL];
}

-(void)loadingAnimation{
    UIImage *gif = [UIImage imageNamed:@"app_loading.gif"];
    self.loadingani.animationDuration = 3.0f;
    self.loadingani.animationRepeatCount = 0;
    [self.loadingani startAnimating];
    [self.loadingani setImage:gif];
}

-(BOOL)prefersStatusBarHidden{
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
