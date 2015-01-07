//
//  ViewController.m
//  my-oschina
//
//  Created by jjx on 14/10/29.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //[self.tabBar setHidden:YES];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTabBar) name:@"showTabBar" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideTabBar) name:@"hideTabBar" object:nil];
}

- (BOOL)isConnectionAvailable
{

    BOOL isExistenceNetwork = YES;
    Reachability* reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
    case NotReachable:
        isExistenceNetwork = NO;
        //NSLog(@"notReachable");
        break;
    case ReachableViaWiFi:
        isExistenceNetwork = YES;
        //NSLog(@"WIFI");
        break;
    case ReachableViaWWAN:
        isExistenceNetwork = YES;
        //NSLog(@"3G");
        break;
    }

    if (!isExistenceNetwork) {
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES]; //<span style="font-family: Arial, Helvetica, sans-serif;">MBProgressHUD为第三方库，不需要可以省略或使用AlertView</span>
        hud.removeFromSuperViewOnHide = YES;
        hud.mode = MBProgressHUDModeText;
        //hud.labelText = NSLocalizedString(INFO_NetNoReachable, nil);
        hud.minSize = CGSizeMake(132.f, 108.0f);
        [hud hide:YES afterDelay:3];
        return NO;
    }

    return isExistenceNetwork;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showTabBar
{
    [self.tabBar setHidden:NO];
}

- (void)hideTabBar
{
    [self.tabBar setHidden:YES];
}

@end
