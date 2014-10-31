//
//  CommentDetails.h
//  my-oschina
//
//  Created by jjx on 14/10/31.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CommentMsgDetails : NSObject

@property (nonatomic,copy) NSString *cId;
@property (nonatomic,copy) NSString *cPortrait;
@property (nonatomic,copy) NSString *cAuthor;
@property (nonatomic,copy) NSString *cAuthorid;
@property (nonatomic,copy) NSString *cContent;
@property (nonatomic,copy) NSString *cPubDate;
@property (nonatomic,copy) NSString *cAppClient;
@property (nonatomic,copy) NSString *cRefers;
@property (nonatomic,strong) NSArray *refrenceArray;


- (id) initWithContent:(NSString *) nId andPortrait:(NSString *)nPortrait andAuthor:(NSString *)nAuthor andAuthorid:(NSString *)nauthorId andContent:(NSString *)nContent andPubDate:(NSString *)npubDate andAppClent:(NSString *)nAppClent andRefers:(NSString*)nRefers;

@end


@interface ReferenceMsg : NSObject

@property (nonatomic,copy) NSString *referbody;
@property (nonatomic,copy) NSString *refertitle;

- (id) initWithContent:(NSString*) nreferbody andrefertitle:(NSString *)nrefertitle;


@end