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

@interface CommentCell : UITableViewCell

@property (strong,nonatomic) UIImageView  *avatarImage;
@property (strong,nonatomic) UILabel *authorLabel;
@property (strong,nonatomic) UIView *myView;
@property (strong,nonatomic) UILabel *commentLabel;

- (void)setContent:(CommentMsgDetails *)msg;

@end
