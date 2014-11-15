//
//  CustomProtocol.h
//  my-oschina
//
//  Created by jjx on 14/11/15.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#ifndef my_oschina_CustomProtocol_h
#define my_oschina_CustomProtocol_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ViewProtocol

- (void) barButttonClick;

@end

@protocol TabBarProtocol

- (void) setBarTitle:(NSString*) title;
- (void) setBarTitle:(NSString*) title andButtonTitle:(NSString *) buttonTitle;
- (void) setBarTitle:(NSString *)title andButtonTitle:(NSString *)buttonTitle
         andProtocol:(id<ViewProtocol>)nProtocol ;


@end


#endif
