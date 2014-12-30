//
//  MyThread.h
//  my-oschina
//
//  Created by jjx on 14/11/25.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "prefix_define.h"
#import "Helper.h"

@interface MyThread : NSObject <ASIHTTPRequestDelegate>

+ (MyThread*) getInstance;

- (void) pushTweet:(NSString *)msg andImage:(NSData *)img;

@end
