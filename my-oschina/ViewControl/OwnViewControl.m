//
//  OwnViewControl.m
//  my-oschina
//
//  Created by jjx on 14/11/7.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "OwnViewControl.h"

@implementation OwnViewControl

 - (void) viewDidLoad
{
    [super viewDidLoad];
    
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请登陆后查看信息" delegate:self cancelButtonTitle:@"返回" destructiveButtonTitle:nil otherButtonTitles:@"登陆", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex ==0)
    {
        LoginViewControl *loginViewControl = [[LoginViewControl alloc] init];
        loginViewControl.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:loginViewControl animated:YES];
    }
}

@end
