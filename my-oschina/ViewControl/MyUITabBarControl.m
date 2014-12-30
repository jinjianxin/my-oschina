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


- (void) viewDidLoad
{
    barButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 50)];
    [barButton setTitle:@"" forState:UIControlStateNormal];
    [barButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [barButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [barButton addTarget:self action:@selector(clickSearch:) forControlEvents:UIControlEventTouchDown];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void) viewDidAppear:(BOOL)animated
{    

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
    [barButton setTitle:buttonTitle forState:UIControlStateHighlighted];
    viewDelegate = nProtocol;
}

@end
