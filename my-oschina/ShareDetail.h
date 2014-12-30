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
@property (weak, nonatomic) IBOutlet UIButton *m_shareSina;
@property (weak, nonatomic) IBOutlet UIButton *m_shareTencentWeiBo;
@property (weak, nonatomic) IBOutlet UIButton *m_shareQQFriend;
@property (weak, nonatomic) IBOutlet UIButton *m_shareWeixin;
@property (weak, nonatomic) IBOutlet UIButton *tecent_sender;
@property (weak, nonatomic) IBOutlet UIButton *friend_sender;
@property (weak, nonatomic) IBOutlet UIButton *weixin_sender;

- (IBAction)sina_sender:(id)sender;


- (void) setMyDelegate:(id<TabBarProtocol>)delegate;

@end
