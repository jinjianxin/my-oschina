//
//  ReportViewControl.m
//  my-oschina
//
//  Created by jjx on 14/11/5.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "ReportViewControl.h"

@implementation ReportViewControl
{
    id<TabBarProtocol> mydelegate;

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [mydelegate setBarTitle:@"举报原因" andButtonTitle:@"举报" andProtocol:self];
}

- (void)setMyDelegate:(id<TabBarProtocol>)delegate
{
    mydelegate = delegate;

}

- (void) barButttonClick
{
    
}

@end
