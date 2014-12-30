//
//  ReplyCiewControl.h
//  my-oschina
//
//  Created by jjx on 14/11/3.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentsDetail.h"


@interface ReplyViewControl : UIViewController <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *m_author;
@property (weak, nonatomic) IBOutlet UILabel *m_content;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_bottom;
@property (weak, nonatomic) IBOutlet UITextView *m_textView;

/*
@property (strong,nonatomic) UILabel *author;
@property (strong,nonatomic) UILabel *content;
@property (strong,nonatomic) UITextView *replyTextView;*/
@property (strong,nonatomic) CommentMsgDetails *m_msg;

@end
