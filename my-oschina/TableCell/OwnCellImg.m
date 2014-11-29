//
//  OwnCellImg.m
//  my-oschina
//
//  Created by jjx on 14/11/25.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "OwnCellImg.h"

@implementation OwnCellImg


@synthesize m_height;

@synthesize m_author;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    return self;
}

- (void)setContent:(OwnMsg *)msg
{
    if(self)
    {
        [AsyncImageView cancelPreviousPerformRequestsWithTarget:self.m_avator];
        self.m_avator.imageURL = [NSURL URLWithString:msg.m_portrait];
        [AsyncImageView cancelPreviousPerformRequestsWithTarget:self.m_imageView];
        self.m_imageView.imageURL = [NSURL URLWithString:msg.m_tweetimage];
        
        //self.m_author.text= msg.m_author;
        
        [m_author setText:msg.m_content];
        
        //  self.m_content.text = msg.m_message;
        //self.m_pullDate.text = [XmlParser intervalSinceNow:msg.m_pubDate] ;//msg.m_pubDate;
    }
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    CGSize optimumSize = [self.m_author optimumSize];
    m_height = (int)optimumSize.height+5;
    self.m_authorHeight.constant = m_height;
    
}


@end
