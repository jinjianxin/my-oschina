//
//  MoreViewControl.m
//  my-oschina
//
//  Created by jjx on 14/11/9.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "MoreViewControl.h"

@implementation MoreViewControl

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = (int)indexPath.section;
    int row = (int)indexPath.row;
 
    if(section ==0)
    {
        if(row ==0)
        {
            [self login];
        }
        else if(row ==1)
        {
            [self qrCode];
        }
        else if(row ==2)
        {
            [self logout];
        }
        
    }else if(section ==1)
    {
        if(row ==0)
        {
            [self software];
        }
        else if(row ==1)
        {
            [self search];
        }
    }
    else if(section ==2)
    {
        if(row ==0)
        {
            [self feedback];
        }
        else if(row ==1)
        {
            [self tweet];
        }
        else if(row ==2)
        {
            [self about];
        }
        else if(row ==3)
        {
            [self checkUpdate];
        }
        else if(row ==4)
        {
            [self score];
        }
    }
}

- (void) login
{
    LoginViewControl *login = [[LoginViewControl alloc] init];
    login.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:login animated:YES];
}

- (void) qrCode
{
    /*
    QrcodeViewControl *qrcode = [[QrcodeViewControl alloc] init];
    qrcode.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:qrcode animated:YES]; */

}

- (void) logout
{
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    
    [userData removeObjectForKey:@"user"];
    [userData removeObjectForKey:@"pwd"];
    [userData removeObjectForKey:@"uid"];
    
    [userData synchronize];
}

- (void) software
{
    
}

- (void) search
{
    
}

- (void) feedback
{
    
}

- (void) tweet
{
    
}

- (void) about
{
    
}

- (void) checkUpdate
{
    
}

- (void) score
{
    
}

@end
