//
//  OwnCell.h
//  my-oschina
//
//  Created by jjx on 14/11/8.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "OwnMsg.h"
#import "XmlParser.h"
#import "RTLabel.h"


@interface OwnCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *m_avator;

@property (weak, nonatomic) IBOutlet RTLabel *m_author;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_authorHeight;

@property int m_height;

- (void) setContent:(OwnMsg*)msg;

@end
