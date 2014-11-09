//
//  OwnCell.m
//  my-oschina
//
//  Created by jjx on 14/11/8.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "OwnCell.h"

@implementation OwnCell

@synthesize m_avator;
@synthesize m_ownName;
@synthesize m_answer;
@synthesize m_question;
@synthesize m_content;
@synthesize m_time;
@synthesize m_height;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    return self;
}

- (void)setContent:(OwnMsg *)msg
{
    [self initView:msg];
}

- (void) initView:(OwnMsg*) msg
{
    if(self.m_avator)
    {
        [AsyncImageView cancelPreviousPerformRequestsWithTarget:self.m_avator];
        [self.m_avator removeFromSuperview];
    }
    
    if(self.m_ownName)
    {
        [self.m_ownName removeFromSuperview];
    }
    
    if(self.m_content)
    {
        [self.m_content removeFromSuperview];
    }
    
    if(self.m_time)
    {
        [self.m_time removeFromSuperview];
    }
    
    m_avator = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    m_avator.image = [UIImage imageNamed:@"big_avatar_loading"];
    m_avator.imageURL = [NSURL URLWithString:msg.m_portrait];
    
    m_ownName = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 300, msg.m_height -80)];
    NSString *str = [NSString stringWithFormat:@"%@ 回答了问题：%@",@"xjnzy",msg.m_objecttitle];
    m_ownName.numberOfLines = 0;
    m_ownName.text = str;
    m_ownName.font = [UIFont fontWithName:@"" size:14];
    
    m_content = [[UILabel alloc] initWithFrame:CGRectMake(60, msg.m_height-70, 300, 30)];
    m_content.numberOfLines = 0;
    m_content.text = msg.m_message;
    m_content.font = [UIFont fontWithName:@"" size:16];
    
    m_time = [[UILabel alloc] initWithFrame:CGRectMake(60, msg.m_height-40, 300, 30)];
    m_time.numberOfLines = 0;
    m_time.text = msg.m_pubDate;
    m_time.font = [UIFont fontWithName:@"" size:14];

    self.m_height = msg.m_height;
    
    [self addSubview:m_avator];
    [self addSubview:m_ownName];
    [self addSubview:m_content];
    [self addSubview:m_time];
}

@end
