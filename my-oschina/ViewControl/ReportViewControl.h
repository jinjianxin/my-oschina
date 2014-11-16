//
//  ReportViewControl.h
//  my-oschina
//
//  Created by jjx on 14/11/5.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomProtocol.h"

@interface ReportViewControl : UIViewController <ViewProtocol>

-(void) setMyDelegate:(id<TabBarProtocol>)delegate;

@end
