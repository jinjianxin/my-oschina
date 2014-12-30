//
//  CommentCell.m
//  my-oschina
//
//  Created by jjx on 14/11/2.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

@synthesize m_avatarImage;
@synthesize m_authorLabel;
@synthesize m_myView;
@synthesize m_commentLabel;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    return self;
    
}

- (void) setContent:(CommentMsgDetails *)msg
{
   if(self)
   {
       [self initView:msg];
   }
}

- (void) initView:(CommentMsgDetails *) msg
{
    
    if(self.m_avatarImage)
    {
        [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:m_avatarImage];
        [self.m_avatarImage removeFromSuperview];
    }
    
    if(self.m_authorLabel)
    {
        [self.m_authorLabel removeFromSuperview];
    }
    
    if(self.m_myView)
    {
        [self.m_myView removeFromSuperview];
    }
    
    if(self.m_commentLabel)
    {
        [self.m_commentLabel removeFromSuperview];
    }
    
    m_avatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    m_avatarImage.image = [UIImage imageNamed:@"big_avatar_loading"];
    
    m_avatarImage.imageURL = [NSURL URLWithString:msg.m_portrait];
    
    
    m_authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 360, 30)];
    NSString *str = [NSString stringWithFormat:@"%@  发表于%@ ",msg.m_author,[XmlParser intervalSinceNow:msg.m_pubDate]];
    m_authorLabel.text = str;
    m_authorLabel.font = [UIFont fontWithName:@"Arial" size:14];
    
    m_myView = [[UIView alloc] initWithFrame:CGRectMake(80, 20, 360, 100)];
   
    for (int i =0; i<msg.m_refrenceArray.count; i++) {
        ReferenceMsg *ref = [msg.m_refrenceArray objectAtIndex:i];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,20+i*40,200,15)];
        label.font = [UIFont fontWithName:@"Arial" size:14];
        label.text = ref.m_refertitle;
        label.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:228.0/255 alpha:1.0];
        
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(5, 40+i*40, 200, 15)];
        content.font = [UIFont fontWithName:@"Arial" size:14];
        content.text = ref.m_referbody;
        content.backgroundColor = [UIColor whiteColor];
        
        
        [self.m_myView addSubview:label];
        [self.m_myView addSubview:content];
    
    }

    int count =(int)[msg.m_refrenceArray count];
    
    if(count ==0)
    {
        m_commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 200, 30)];
    }
    else{
        m_commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30+count*40 , 200, 30)];
    }
    
    m_commentLabel.text = msg.m_content;
    m_commentLabel.font = [UIFont fontWithName:@"Arial" size:16];
    

    
    [self addSubview:m_avatarImage];
    [self addSubview:m_authorLabel];
    [self addSubview:m_myView];
    [self addSubview:m_commentLabel];
    
}


@end
