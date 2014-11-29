//
//  UITip.h
//  my-oschina
//
//  Created by jjx on 14/11/28.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITip : UITapGestureRecognizer

@property (strong,nonatomic) UIImageView *m_imageView;
@property (strong,nonatomic) NSString *m_imageUrl;

@end
