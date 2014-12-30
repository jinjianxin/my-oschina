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

/*
@property (strong,nonatomic) UIImageView *m_avator;
@property (strong,nonatomic) UILabel *m_ownName;
@property (strong,nonatomic) UILabel *m_answer;
@property (strong,nonatomic) UILabel *m_question;
@property (strong,nonatomic) UILabel *m_content;
@property (strong,nonatomic) UILabel *m_time;
@property int m_height;

- (void) setContent:(OwnMsg*)msg;
 */
@property (weak, nonatomic) IBOutlet UIImageView *m_avator;

//@property (weak, nonatomic) IBOutlet UILabel *m_author;
@property (weak, nonatomic) IBOutlet RTLabel *m_author;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_authorHeight;

//@property (strong,nonatomic) RTLabel *m_author;
@property int m_height;

- (void) setContent:(OwnMsg*)msg;

@end
