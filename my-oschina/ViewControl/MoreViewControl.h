//
//  MoreViewControl.h
//  my-oschina
//
//  Created by jjx on 14/11/9.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewControl.h"
#import "QrcodeViewControl.h"

@interface MoreViewControl : UITableViewController

- (void) login;
- (void) qrCode;
- (void) logout;
- (void) software;
- (void) search;
- (void) feedback;
- (void) tweet;
- (void) about;
- (void) checkUpdate;
- (void) score;

@end