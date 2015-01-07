//
//  PubComments.h
//  my-oschina
//
//  Created by jjx on 14/11/18.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "prefix_define.h"
#import "TBXML.h"
#import "CommentMsgDetails.h"
#import "CommentsDetail.h"

@interface PubComments : UIViewController <ASIHTTPRequestDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UILabel* m_title;
@property (strong, nonatomic) UITextView* m_commentView;

@property (strong, nonatomic) NSString* m_id;
@property (strong, nonatomic) NSString* m_catalog;
@property (strong, nonatomic) NSString* m_uid;
@property id m_parent;

@end
