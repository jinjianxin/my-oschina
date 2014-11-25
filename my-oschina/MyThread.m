//
//  MyThread.m
//  my-oschina
//
//  Created by jjx on 14/11/25.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "MyThread.h"

@implementation MyThread


+ (MyThread*)getInstance
{
    static MyThread *myThread = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myThread = [[self alloc] init];
    });
    
    return myThread;
}

- (void)pushTweet:(NSString *)msg andImage:(NSData *)img
{
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:api_tweet_pub]];
    //[request setUseCookiePersistence:[Config Instance].isCookie];
    [request setPostValue:[Helper getUid] forKey:@"uid"];
    [request setPostValue:msg forKey:@"msg"];
    [request addData:img withFileName:@"img.jpg" andContentType:@"image/jpeg" forKey:@"img"];
    [request setDelegate:self];
    request.tag = 10;
   // [request setDidFailSelector:@selector(requestFailed:)];
    //[request setDidFinishSelector:@selector(requestPub:)];
    [request startAsynchronous];

}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"%@",request.responseString);
    
    //如果发送tweet失败
    if (request.tag == 10) {
        NSLog(@"后台发送动弹图片  网络失败");
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *response = request.responseString;
    
    TBXML *tbxml  = [TBXML newTBXMLWithXMLString:response error:nil];
    
    assert(tbxml!=nil);
    
    TBXMLElement *root= tbxml.rootXMLElement;
    
    assert(root!=nil);
    
    TBXMLElement *_result = [TBXML childElementNamed:@"result" parentElement:root];
    assert(_result!=nil);
    
    TBXMLElement *_errorCode = [TBXML childElementNamed:@"" parentElement:_result];
    assert(_errorCode!=nil);
    
    int errorCode = [[TBXML textForElement:_errorCode] intValue];
    
    if(errorCode ==1)
    {
        
    }
    else{
        
    }

}

@end
