//
//  TweetViewControl.h
//  my-oschina
//
//  Created by jjx on 14/11/5.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"

@interface TweetViewControl : UIViewController <PullTableViewDelegate>

@property (weak, nonatomic) IBOutlet PullTableView *pullTableView;


- (IBAction)segSender:(id)sender;
@end
