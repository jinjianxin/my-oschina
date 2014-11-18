//
//  PubComments.m
//  my-oschina
//
//  Created by jjx on 14/11/18.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "PubComments.h"

@implementation PubComments

@synthesize m_title;
@synthesize m_commentView;

-(void)loadView
{
    [super loadView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [button setTitle:@"立即发表" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = item;
    
    m_title = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 100, 50)];
    [m_title setText:@"我要评论"];

    
    m_commentView = [[UITextView alloc] initWithFrame:CGRectMake(20, 120, 330, 150)];
    m_commentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    m_commentView.layer.borderWidth =1.0;
    m_commentView.layer.cornerRadius =5.0;
    [m_commentView setFont:[UIFont fontWithName:@"" size:20] ];
    
    
    [self.view addSubview:m_title];
    [self.view addSubview:m_commentView];
    
    UITapGestureRecognizer* gesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(hideKeyboard)];
    gesture.numberOfTapsRequired = 1; //手势敲击的次数
    [self.view addGestureRecognizer:gesture];
    
    
}

-(void)hideKeyboard
{
    [m_commentView resignFirstResponder];
}

- (void) rightClick:(id)sender
{
    
}

@end
