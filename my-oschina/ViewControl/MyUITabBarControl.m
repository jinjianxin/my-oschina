//
//  MyUITabBarControl.m
//  my-oschina
//
//  Created by jjx on 14/11/15.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "MyUITabBarControl.h"


@implementation MyUITabBarControl
{
    id<ViewProtocol> viewDelegate;
    UIButton *barButton;
}


- (void) viewDidAppear:(BOOL)animated
{
    self.title = @"咨询详情";
    
    barButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
    [barButton setTitle:@"收藏此文" forState:UIControlStateNormal];
    [barButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [barButton setTitleColor:[UIColor redColor] forState:UIControlStateReserved];
    [barButton addTarget:self action:@selector(clickSearch:) forControlEvents:UIControlEventTouchDown];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:barButton];

    self.navigationItem.rightBarButtonItem = item;
}


-(void) clickSearch:(id)sender
{
    [viewDelegate barButttonClick];
}

- (void)setBarTitle:(NSString *)title
{
    self.title = title;
}

-(void)setBarTitle:(NSString *)title andButtonTitle:(NSString *)buttonTitle
{
    self.title = title;
}

-(void) setBarTitle:(NSString *)title andButtonTitle:(NSString *)buttonTitle andProtocol:(id<ViewProtocol>)nProtocol
{
    self.title = title;
    [barButton setTitle:buttonTitle forState:UIControlStateNormal];
    viewDelegate = nProtocol;
}

@end
