//
//  OwnCellImg.h
//  my-oschina
//
//  Created by jjx on 14/11/25.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "OwnMsg.h"
#import "XmlParser.h"
#import "RTLabel.h"



@interface OwnCellImg : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *m_avator;

//@property (weak, nonatomic) IBOutlet UILabel *m_author;
@property (weak, nonatomic) IBOutlet RTLabel *m_author;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_authorHeight;

//@property (strong,nonatomic) RTLabel *m_author;
@property int m_height;
@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

- (void) setContent:(OwnMsg*)msg;


@end
