//
//  ShareDetail.m
//  my-oschina
//
//  Created by jjx on 14/10/31.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "ShareDetail.h"

@implementation ShareDetail

@synthesize shareRenren;
@synthesize shareSina;
@synthesize shareTent;
@synthesize shareWeichat;

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    shareSina = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    shareSina.frame = CGRectMake(15, 150, 348, 63);
    [shareSina setBackgroundImage:[UIImage imageNamed:@"share_sina"] forState:UIControlStateNormal];
    
    shareRenren =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    shareRenren.frame = CGRectMake(15, 250, 348, 63);
    [shareRenren setBackgroundImage:[UIImage imageNamed:@"share_weixin"] forState:UIControlStateNormal];
    
    
    shareTent =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    shareTent.frame = CGRectMake(15, 350, 348, 63);
    [shareTent setBackgroundImage:[UIImage imageNamed:@"share_weixinFriend"] forState:UIControlStateNormal];
    
    shareWeichat =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    shareWeichat.frame = CGRectMake(15, 450, 348, 63);
    [shareWeichat setBackgroundImage:[UIImage imageNamed:@"share_tencent"] forState:UIControlStateNormal];
    
    [shareSina addTarget:self action:@selector(sinaAction:) forControlEvents:UIControlEventTouchUpInside];
    [shareTent addTarget:self action:@selector(tentAction:) forControlEvents:UIControlEventTouchUpInside];
    [shareRenren addTarget:self action:@selector(RenrenAction:) forControlEvents:UIControlEventTouchUpInside];
    [shareWeichat addTarget:self action:@selector(weichatAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:shareSina];
    [self.view addSubview:shareRenren];
    [self.view addSubview:shareTent];
    [self.view addSubview:shareWeichat];
    
    
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
