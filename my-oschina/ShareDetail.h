//
//  ShareDetail.h
//  my-oschina
//
//  Created by jjx on 14/10/31.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgDetail.h"
#import "CustomProtocol.h"


@interface ShareDetail : UIViewController <ViewProtocol>

@property (strong,nonatomic) UIButton  *shareSina;
@property (strong,nonatomic) UIButton  *shareTent;
@property (strong,nonatomic) UIButton  *shareRenren;
@property (strong,nonatomic) UIButton  *shareWeichat;

- (void) setMyDelegate:(id<TabBarProtocol>)delegate;

@end
