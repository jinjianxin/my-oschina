//
//  ReplyCiewControl.h
//  my-oschina
//
//  Created by jjx on 14/11/3.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentsDetail.h"


@interface ReplyCiewControl : UIViewController <UITextViewDelegate>

@property (strong,nonatomic) UILabel *author;
@property (strong,nonatomic) UILabel *content;
@property (strong,nonatomic) UITextView *replyTextView;
@property (strong,nonatomic) CommentMsgDetails *msg;


@end
