//
//  ShareDetail.m
//  my-oschina
//
//  Created by jjx on 14/10/31.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "ShareDetail.h"

@implementation ShareDetail
{
    id<TabBarProtocol> mydelegate;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [mydelegate setBarTitle:@"分享" andButtonTitle:@"" andProtocol:self];
}

-(void) barButttonClick
{
    
}


- (IBAction)sina_sender:(id)sender {
}

-(void) setMyDelegate:(id)delegate
{
    mydelegate = delegate;
}

-(void)sinaAction:(id)sender {
    
}

-(void)tentAction:(id)sender {
    
}

-(void)RenrenAction:(id)sender {
    
}

-(void)weichatAction:(id)sender {
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

@end
