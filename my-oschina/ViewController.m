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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //[self.tabBar setHidden:YES];
    
    
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(showTabBar) name:@"showTabBar" object:nil];
    
    
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(hideTabBar) name:@"hideTabBar" object:nil];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) showTabBar
{
    [self.tabBar setHidden:NO];
}

- (void) hideTabBar
{
    [self.tabBar setHidden:YES];
}



@end
