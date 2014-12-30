//
//  CommentCell.h
//  my-oschina
//
//  Created by jjx on 14/11/2.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentMsgDetails.h"
#import "XmlParser.h"
#import "AsyncImageView.h"

@interface CommentCell : UITableViewCell

@property (strong,nonatomic) UIImageView  *m_avatarImage;
@property (strong,nonatomic) UILabel *m_authorLabel;
@property (strong,nonatomic) UIView *m_myView;
@property (strong,nonatomic) UILabel *m_commentLabel;

- (void)setContent:(CommentMsgDetails *)msg;

@end
