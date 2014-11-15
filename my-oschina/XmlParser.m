//
//  XmlParser.m
//  my-oschina
//
//  Created by jjx on 14/10/29.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "XmlParser.h"
#import "MsgDetail.h"

@implementation XmlParser

+ (NSMutableArray *) newsParser:(NSString *)response
{
    
    NSMutableArray *newsArray = [[NSMutableArray alloc] initWithCapacity:10];
    
    TBXML *tbxml = [TBXML newTBXMLWithXMLString:response error:nil];
    
    if(tbxml!=nil)
    {
        TBXMLElement *root = tbxml.rootXMLElement;
        
        if(root!=nil)
        {
            TBXMLElement *childElement = [TBXML childElementNamed:@"newslist" parentElement:root];
            
            if(childElement!=nil)
            {
                
                TBXMLElement *test = [TBXML childElementNamed:@"news" parentElement:childElement];
                
                while (test!=nil) {
                    
                    TBXMLElement *idElement = [TBXML childElementNamed:@"id" parentElement:test];
                    NSString *ids = [TBXML textForElement:idElement];
                    
                    TBXMLElement *contentEle = [TBXML childElementNamed:@"title" parentElement:test];
                    NSString *content = [TBXML textForElement:contentEle];
                    
                    TBXMLElement *authorEle = [TBXML childElementNamed:@"author" parentElement:test];
                    NSString *author = [TBXML textForElement:authorEle];
                    
                    TBXMLElement *dateEle = [TBXML childElementNamed:@"pubDate" parentElement:test];
                    NSString *pullData = [XmlParser intervalSinceNow:[TBXML textForElement:dateEle]] ;
                    
                    MsgDetail *news = [[MsgDetail alloc] initwithContent:content author:author ids:ids pullDate:pullData];
                    
                    [newsArray addObject:news];
                    
                    test = [TBXML nextSiblingNamed:@"news" searchFromElement:test];
                }
                
            }
            
        }
    }
    
    return newsArray;

}

+ (NSMutableArray *) blogParser:(NSString *)response
{
    
    NSMutableArray *newsArray = [[NSMutableArray alloc] initWithCapacity:10];
    
    TBXML *tbxml = [TBXML newTBXMLWithXMLString:response error:nil];
    
    if(tbxml!=nil)
    {
        TBXMLElement *root = tbxml.rootXMLElement;
        
        if(root!=nil)
        {
            TBXMLElement *childElement = [TBXML childElementNamed:@"blogs" parentElement:root];
            
            if(childElement!=nil)
            {
                
                TBXMLElement *test = [TBXML childElementNamed:@"blog" parentElement:childElement];
                
                
                while (test!=nil) {
                    
                    TBXMLElement *idElement = [TBXML childElementNamed:@"id" parentElement:test];
                    NSString *ids = [TBXML textForElement:idElement];
                    
                    TBXMLElement *contentEle = [TBXML childElementNamed:@"title" parentElement:test];
                    NSString *content = [TBXML textForElement:contentEle];
                    
                    TBXMLElement *authorEle = [TBXML childElementNamed:@"authorname" parentElement:test];
                    NSString *author = [TBXML textForElement:authorEle];
            
                    
                    TBXMLElement *dateEle = [TBXML childElementNamed:@"pubDate" parentElement:test];
                    NSString *pullData = [XmlParser intervalSinceNow:[TBXML textForElement:dateEle]];

                    
                    TBXMLElement *urlEle = [TBXML childElementNamed:@"url" parentElement:test];
                    NSString *url = [TBXML textForElement:urlEle];
                    
                
                    MsgDetail *news = [[MsgDetail alloc] initwithBlog:content author:author ids:ids pullDate:pullData url:url];
                    
                    [newsArray addObject:news];
                    
                    test = [TBXML nextSiblingNamed:@"blog" searchFromElement:test];
                }
                
            }
            
        }
    }
    
    return newsArray;
    

}

+ (SingleNews *) singleNewParser:(NSString *)response
{
    SingleNews *singleNews ;
    
    NSMutableArray *relativeArray = [[NSMutableArray alloc] init];
    
    
    TBXML *tbxml = [TBXML newTBXMLWithXMLString:response error:nil];
    
    if(tbxml!=nil)
    {
        TBXMLElement *root = tbxml.rootXMLElement;
        
        if(root!=nil)
        {
            TBXMLElement *news = [TBXML childElementNamed:@"news" parentElement:root];
            
            if(news!=nil)
            {
                
                TBXMLElement *_id = [TBXML childElementNamed:@"id" parentElement:news];
                TBXMLElement *_title = [TBXML childElementNamed:@"title" parentElement:news];
                TBXMLElement *_url = [TBXML childElementNamed:@"url" parentElement:news];
                TBXMLElement *_body = [TBXML childElementNamed:@"body" parentElement:news];
                TBXMLElement *_author = [TBXML childElementNamed:@"author"parentElement:news];
                TBXMLElement *_authorid = [TBXML childElementNamed:@"authorid"parentElement:news];
                TBXMLElement *_pubDate = [TBXML childElementNamed:@"pubDate" parentElement:news];
                
                
                
                TBXMLElement *_commentCount = [TBXML childElementNamed:@"commentCount" parentElement:news];
                
                TBXMLElement *_softwarelink = [TBXML childElementNamed:@"softwarelink" parentElement:news];
                TBXMLElement *_softwarename = [TBXML childElementNamed:@"softwarename" parentElement:news];
                TBXMLElement *_fav = [TBXML childElementNamed:@"favorite" parentElement:news];
                
                NSLog(@"%@",[TBXML textForElement:_fav]);

                
                TBXMLElement *_relativies = [TBXML childElementNamed:@"relativies" parentElement:news];
                
                if(_relativies!=nil)
                {
                    TBXMLElement *relativieChild = [TBXML childElementNamed:@"relative" parentElement:_relativies];
                    
                    while (relativieChild) {
                        
                        TBXMLElement *_rtitle = [TBXML childElementNamed:@"rtitle"parentElement:relativieChild];
                        
                        TBXMLElement *_rurl = [TBXML childElementNamed:@"rurl" parentElement:relativieChild];
                    
                        RelativeNews *relativeNews = [[RelativeNews alloc] initWithContent:[TBXML textForElement:_rtitle] andUrl:[TBXML textForElement:_rurl]];
                        
                        [relativeArray addObject:relativeNews];
                        
                        relativieChild = [TBXML nextSiblingNamed:@"relative" searchFromElement:relativieChild];
                     
                    }
                }
          
            
                singleNews = [[SingleNews alloc] initWithContent:[[TBXML textForElement:_id] intValue] andtitle:[TBXML textForElement:_title] andurl:[TBXML textForElement:_url] andbody:[TBXML textForElement:_body] andauthor:[TBXML textForElement:_author] andauthorid:[[TBXML textForElement:_authorid] intValue] andpubDate:[TBXML textForElement:_pubDate] andcommentCount:[[TBXML textForElement:_commentCount] intValue] andfavorite:_fav];
                
                singleNews.softwarelink = [TBXML textForElement:_softwarelink];
                singleNews.softwarename = [TBXML textForElement:_softwarename];
                singleNews.relativies = relativeArray;
                
                
            }
            
        }
    }
    

    
    return singleNews;
    
}

+ (NSString *)intervalSinceNow: (NSString *) theDate
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    NSTimeInterval cha=now-late;
    
    if (cha/3600<1) {
        if (cha/60<1) {
            timeString = @"1";
        }
        else
        {
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
        }
        
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    else if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    else if (cha/86400>1&&cha/864000<1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    else
    {
        NSArray *array = [theDate componentsSeparatedByString:@" "];
        
        timeString = [array objectAtIndex:0];
    }
    return timeString;
}

+ (NSString *)generateRelativeNewsString:(NSArray *)array
{
    if (array == nil || [array count] == 0) {
        return @"";
    }
    NSString *middle = @"";
    for (RelativeNews *r in array) {
        middle = [NSString stringWithFormat:@"%@<a href=%@ style='text-decoration:none'>%@</a><p/>",middle, r.rurl, r.rtitle];
    }
    return [NSString stringWithFormat:@"<hr/>相关文章<div style='font-size:14px'><p/>%@</div>", middle];
}

+ (BlogDetails*) blogDetailParser:(NSString *)response
{
    TBXML *xml = [[TBXML alloc] initWithXMLString:response error:nil];
    TBXMLElement *root = xml.rootXMLElement;
    TBXMLElement *blog = [TBXML childElementNamed:@"blog" parentElement:root];
    if (blog == nil) {
        return nil;
    }
    TBXMLElement *_id = [TBXML childElementNamed:@"id" parentElement:blog];
    TBXMLElement *title = [TBXML childElementNamed:@"title" parentElement:blog];
    TBXMLElement *url = [TBXML childElementNamed:@"url" parentElement:blog];
    TBXMLElement *where = [TBXML childElementNamed:@"where" parentElement:blog];
    TBXMLElement *body = [TBXML childElementNamed:@"body" parentElement:blog];
    TBXMLElement *author = [TBXML childElementNamed:@"author" parentElement:blog];
    TBXMLElement *authorid = [TBXML childElementNamed:@"authorid" parentElement:blog];
    TBXMLElement *documentType = [TBXML childElementNamed:@"documentType" parentElement:blog];
    TBXMLElement *pubDate = [TBXML childElementNamed:@"pubDate" parentElement:blog];
    TBXMLElement *fav = [TBXML childElementNamed:@"favorite" parentElement:blog];
    TBXMLElement *commentCount = [TBXML childElementNamed:@"commentCount" parentElement:blog];
    
  
    BlogDetails *b = [[BlogDetails alloc] initWithParameters:[[TBXML textForElement:_id] intValue] andTitle:[TBXML textForElement:title] andWhere:[TBXML textForElement:where] andBody:[TBXML textForElement:body] andAuthor:[TBXML textForElement:author] andAuthorid:[[TBXML textForElement:authorid] intValue] andDocumentType:[[TBXML textForElement:documentType] intValue] andPubDate:[TBXML textForElement:pubDate] andFavorite:[[TBXML textForElement:fav] intValue] == 1 andUrl:[TBXML textForElement:url] andCommentCount:[[TBXML textForElement:commentCount] intValue]];
    return b;

}

+ (NSMutableArray *) commentsDetailParser:(NSString *)response
{
    
    NSMutableArray *commentArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    TBXML *xml = [[TBXML alloc] initWithXMLString:response error:nil];
    TBXMLElement *root = xml.rootXMLElement;
    TBXMLElement *blog = [TBXML childElementNamed:@"comments" parentElement:root];
    if (blog == nil) {
        return nil;
    }
    
    TBXMLElement *first = [TBXML childElementNamed:@"comment" parentElement:blog];
    
    while (first!=nil) {
        
        TBXMLElement *_id = [TBXML childElementNamed:@"id" parentElement:first];
        TBXMLElement *_portrait = [TBXML childElementNamed:@"portrait" parentElement:first];
        TBXMLElement *_author = [TBXML childElementNamed:@"author" parentElement:first];
        TBXMLElement *_authorid = [TBXML childElementNamed:@"authorid" parentElement:first];
        TBXMLElement *_content = [TBXML childElementNamed:@"content" parentElement:first];
        TBXMLElement *_pubDate = [TBXML childElementNamed:@"pubDate" parentElement:first];
        TBXMLElement *_appclient = [TBXML childElementNamed:@"appclient" parentElement:first];
        TBXMLElement *_refers = [TBXML childElementNamed:@"refers" parentElement:first];
        
        NSMutableArray *referenceArray =  nil;

        
        if(_refers!=nil)
        {
            referenceArray = [[NSMutableArray alloc] initWithCapacity:2];
            
        TBXMLElement *_refersChild = [TBXML childElementNamed:@"refer" parentElement:_refers];
            
        while (_refersChild!=nil) {
            
            TBXMLElement *_refertitle = [TBXML childElementNamed:@"refertitle" parentElement:_refersChild];
            TBXMLElement *_referbody = [TBXML childElementNamed:@"referbody" parentElement:_refersChild];
    
            ReferenceMsg *msg = [[ReferenceMsg alloc] initWithContent:[TBXML textForElement:_referbody] andrefertitle:[TBXML textForElement:_refertitle]];
            
            [referenceArray addObject:msg];
            
             _refersChild = [TBXML nextSiblingNamed:@"refer" searchFromElement:_refersChild];
        }
        }
    
        NSString *_refersContent = nil;
        
        if(_refers!=nil)
        {
            _refersContent = [TBXML textForElement:_refers];
        }
        
        CommentMsgDetails *news = [[CommentMsgDetails alloc] initWithContent:[TBXML textForElement:_id] andPortrait:[TBXML textForElement:_portrait] andAuthor:[TBXML textForElement:_author] andAuthorid:[TBXML textForElement:_authorid] andContent:[TBXML textForElement:_content] andPubDate:[TBXML textForElement:_pubDate] andAppClent:[TBXML textForElement:_appclient] andRefers:_refersContent];
        
        news.refrenceArray = referenceArray;
        [news calculateHeight];
        
        
        
        [commentArray addObject:news];
        
        first = [TBXML nextSiblingNamed:@"comment" searchFromElement:first];
    }
    
    
    return commentArray;
}

+ (NSMutableArray *) questionNewParser:(NSString *)response
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:2];
    
    
    TBXML *xml = [[TBXML alloc] initWithXMLString:response error:nil];
    TBXMLElement *root = xml.rootXMLElement;
    TBXMLElement *blog = [TBXML childElementNamed:@"posts" parentElement:root];
    if (blog == nil) {
        return nil;
    }
    
    TBXMLElement *first = [TBXML childElementNamed:@"post" parentElement:blog];
    
    while (first!=nil) {
        
        TBXMLElement *_id = [TBXML childElementNamed:@"id" parentElement:first];
        TBXMLElement *_portrait = [TBXML childElementNamed:@"portrait" parentElement:first];
        TBXMLElement *_author = [TBXML childElementNamed:@"author" parentElement:first];
        TBXMLElement *_authorid = [TBXML childElementNamed:@"authorid" parentElement:first];
        TBXMLElement *_title = [TBXML childElementNamed:@"title" parentElement:first];
        TBXMLElement *_answerCount = [TBXML childElementNamed:@"answerCount" parentElement:first];
        TBXMLElement *_viewCount = [TBXML childElementNamed:@"viewCount" parentElement:first];
        TBXMLElement *_pubDate = [TBXML childElementNamed:@"pubDate" parentElement:first];
        TBXMLElement *_answer = [TBXML childElementNamed:@"answer" parentElement:first];
        TBXMLElement *_name = nil;
        if(_answer!=nil)
        {
            _name = [TBXML childElementNamed:@"name" parentElement:_answer];
        }
        
    
        QuestionMsg *msg = [[QuestionMsg alloc] initWithContent:[TBXML textForElement:_id] andPortrait:[TBXML textForElement:_portrait] andAuthor:[TBXML textForElement:_author] andAuthorid:[TBXML textForElement:_authorid] andTitle:[TBXML textForElement:_title] andAnswerCount:[TBXML textForElement:_answerCount] andViewCount:[TBXML textForElement:_viewCount] andPubDate:[TBXML textForElement:_pubDate] andName:nil];
        
        if(_name!=nil)
        {
            msg.name = [TBXML textForElement:_name];
        }
        
        [array addObject:msg];
        
        first = [TBXML nextSiblingNamed:@"post" searchFromElement:first];
    }
    

    
    return array;
}

+ (PostMsg*) postNewParser:(NSString *)response
{
    TBXML *xml = [[TBXML alloc] initWithXMLString:response error:nil];
    TBXMLElement *root = xml.rootXMLElement;
    TBXMLElement *post = [TBXML childElementNamed:@"post" parentElement:root];
    if (post == nil) {
        return nil;
    }
    TBXMLElement *_id = [TBXML childElementNamed:@"id" parentElement:post];
    TBXMLElement *title = [TBXML childElementNamed:@"title" parentElement:post];
    TBXMLElement *url = [TBXML childElementNamed:@"url" parentElement:post];
    TBXMLElement *portrait = [TBXML childElementNamed:@"portrait" parentElement:post];
    TBXMLElement *body = [TBXML childElementNamed:@"body" parentElement:post];
    TBXMLElement *author = [TBXML childElementNamed:@"author" parentElement:post];
    TBXMLElement *authorid = [TBXML childElementNamed:@"authorid" parentElement:post];
    TBXMLElement *answerCount = [TBXML childElementNamed:@"answerCount" parentElement:post];
    TBXMLElement *viewCount = [TBXML childElementNamed:@"viewCount" parentElement:post];
    TBXMLElement *pubDate = [TBXML childElementNamed:@"pubDate" parentElement:post];
    TBXMLElement *fav = [TBXML childElementNamed:@"favorite" parentElement:post];
    
    NSMutableArray *_tags = [[NSMutableArray alloc] initWithCapacity:0];
    TBXMLElement *tags = [TBXML childElementNamed:@"tags" parentElement:post];
    if (tags != nil) {
        TBXMLElement *tag = [TBXML childElementNamed:@"tag" parentElement:tags];
        if (tag != nil) {
            [_tags addObject:[TBXML textForElement:tag]];
            while (tag != nil) {
                tag = [TBXML nextSiblingNamed:@"tag" searchFromElement:tag];
                if (tag != nil) {
                    [_tags addObject:[TBXML textForElement:tag]];
                }
                else
                    break;
            }
        }
    }

    PostMsg *msg = [[PostMsg alloc] initWithContent:[TBXML textForElement:_id] andTitle:[TBXML textForElement:title] andUrl:[TBXML textForElement:url] andPortrait:[TBXML textForElement:portrait] andBody:[TBXML textForElement:body] andAuthor:[TBXML textForElement:author] andAuthorID:[TBXML textForElement:authorid] andAnswer:[TBXML textForElement:answerCount] andView:[TBXML textForElement:viewCount] andPubDate:[TBXML textForElement:pubDate] andFavorite:[TBXML textForElement:fav] andTags:_tags];
    
    
    return msg;
}

+ (NSMutableArray *) tweetNewParser:(NSString *)response
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:2];
    
    TBXML *xml = [[TBXML alloc] initWithXMLString:response error:nil];
    TBXMLElement *root = xml.rootXMLElement;
    TBXMLElement *blog = [TBXML childElementNamed:@"tweets" parentElement:root];
    if (blog == nil) {
        return nil;
    }
    
    TBXMLElement *first = [TBXML childElementNamed:@"tweet" parentElement:blog];
    
    while (first!=nil) {
        
        TBXMLElement *_id = [TBXML childElementNamed:@"id" parentElement:first];
        TBXMLElement *_portrait = [TBXML childElementNamed:@"portrait" parentElement:first];
        TBXMLElement *_author = [TBXML childElementNamed:@"author" parentElement:first];
        TBXMLElement *_authorid = [TBXML childElementNamed:@"authorid" parentElement:first];
        TBXMLElement *_body = [TBXML childElementNamed:@"body" parentElement:first];
        TBXMLElement *_appclient = [TBXML childElementNamed:@"appclient" parentElement:first];
        TBXMLElement *_commentCount = [TBXML childElementNamed:@"commentCount" parentElement:first];
        TBXMLElement *_pubDate = [TBXML childElementNamed:@"pubDate" parentElement:first];
    
        TweetMsg *msg = [[TweetMsg alloc] initWithContent:[TBXML textForElement:_id] andPortrait:[TBXML textForElement:_portrait] andAuthor:[TBXML textForElement:_author] andAuthorid:[TBXML textForElement:_authorid] andBody:[TBXML textForElement:_body] andAppclient:[TBXML textForElement:_appclient] andCommentCount:[TBXML textForElement:_commentCount] andPullDate:[TBXML textForElement:_pubDate]];
        
        [array addObject:msg];
        
        first = [TBXML nextSiblingNamed:@"tweet" searchFromElement:first];
    }
    
    
    
    return array;

}

+ (UserData *) loginParser:(NSString *)response
{
    
    TBXMLElement *errorEle = nil;
    UserData *data;
    
    
    TBXML *tbxml = [TBXML newTBXMLWithXMLString:response error:nil];
    
    if (tbxml != nil) {
        TBXMLElement *root = tbxml.rootXMLElement;
        
        if (root != nil) {
            TBXMLElement *childElement = [TBXML childElementNamed:@"result" parentElement:root];
            
            if (childElement != nil) {
                
                errorEle = [TBXML childElementNamed:@"errorCode" parentElement:childElement];
            }
            
            TBXMLElement *user = [TBXML childElementNamed:@"user" parentElement:root];
            
            if(user !=nil)
            {
                TBXMLElement *_id = [TBXML childElementNamed:@"uid" parentElement:user];
                TBXMLElement *_location = [TBXML childElementNamed:@"location" parentElement:user];
                TBXMLElement *_name = [TBXML childElementNamed:@"name" parentElement:user];
                TBXMLElement *_followers = [TBXML childElementNamed:@"followers" parentElement:user];
                TBXMLElement *_fans = [TBXML childElementNamed:@"fans" parentElement:user];
                TBXMLElement *_score = [TBXML childElementNamed:@"score" parentElement:user];
                TBXMLElement *_portrait = [TBXML childElementNamed:@"portrait" parentElement:user];
                
                data = [[UserData alloc]initWithContent:[TBXML textForElement:errorEle] andUid:[TBXML textForElement:_id] andLocation:[TBXML textForElement:_location] andName:[TBXML textForElement:_name] andFollowers:[TBXML textForElement:_followers] andFans:[TBXML textForElement:_fans] andScore:[TBXML textForElement:_score] andPortrait:[TBXML textForElement:_portrait]];
                
            }
            
        }
    }
    
    return data;
}

+ (NSMutableArray*) ownNewParser:(NSString *)response
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:2];
    
    
    TBXML *tbxml = [TBXML newTBXMLWithXMLString:response error:nil];
    
    if (tbxml != nil) {
        TBXMLElement *root = tbxml.rootXMLElement;
        
        if (root != nil) {
            TBXMLElement *childElement = [TBXML childElementNamed:@"activies" parentElement:root];
            
            TBXMLElement *activie = [TBXML childElementNamed:@"active" parentElement:childElement];
            
            while (activie!=nil) {
                
                TBXMLElement *_id = [TBXML childElementNamed:@"id" parentElement:activie];
                TBXMLElement *_portrait  = [TBXML childElementNamed:@"portrait" parentElement:activie];
                TBXMLElement *_author = [TBXML childElementNamed:@"author" parentElement:activie];
                TBXMLElement *_authorid = [TBXML childElementNamed:@"authorid" parentElement:activie];
                TBXMLElement *_catalog = [TBXML childElementNamed:@"catalog" parentElement:activie];
                TBXMLElement *_objecttype = [TBXML childElementNamed:@"objecttype" parentElement:activie];
                TBXMLElement *_objectcatalog = [TBXML childElementNamed:@"objectcatalog" parentElement:activie];
                TBXMLElement *_objecttitle = [TBXML childElementNamed:@"objecttitle" parentElement:activie];
                TBXMLElement *_appclient = [TBXML childElementNamed:@"appclient" parentElement:activie];
                TBXMLElement *_url = [TBXML childElementNamed:@"url" parentElement:activie];
                TBXMLElement *_objectID = [TBXML childElementNamed:@"objectID" parentElement:activie];
                TBXMLElement *_message = [TBXML childElementNamed:@"message" parentElement:activie];
                TBXMLElement *_commentCount = [TBXML childElementNamed:@"commentCount" parentElement:activie];
                TBXMLElement *_pubDate = [TBXML childElementNamed:@"pubDate" parentElement:activie];
                TBXMLElement *_tweetimage = [TBXML childElementNamed:@"tweetimage" parentElement:activie];
                
                OwnMsg *msg = [[OwnMsg alloc] init];
                msg.m_id = [TBXML textForElement:_id];
                msg.m_portrait = [TBXML textForElement:_portrait];
                msg.m_author = [TBXML textForElement:_author];
                msg.m_authorid = [TBXML textForElement:_authorid];
                msg.m_catalog = [TBXML textForElement:_catalog];
                msg.m_objecttype = [TBXML textForElement:_objecttype];
                msg.m_objectcatalog = [TBXML textForElement:_objectcatalog];
                msg.m_objecttitle = [TBXML textForElement:_objecttitle];
                msg.m_appclient = [TBXML textForElement:_appclient];
                msg.m_url = [TBXML textForElement:_url];
                msg.m_objectID = [TBXML textForElement:_objectID];
                msg.m_message = [TBXML textForElement:_message];
                msg.m_commentCount = [TBXML textForElement:_commentCount];
                msg.m_pubDate = [TBXML textForElement:_pubDate];
                msg.m_tweetimage = [TBXML textForElement:_tweetimage];
                
                [msg calculateHeight];
                
                [array addObject:msg];
                
                activie = [TBXML nextSiblingNamed:@"active" searchFromElement:activie];
                
            }
            
        }
    }
    
    return array;
}

+ (NSMutableArray *) searchResultParser:(NSString*)response
{
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:2];
    
    TBXML *tbxml = [TBXML newTBXMLWithXMLString:response error:nil];

    TBXMLElement *root = tbxml.rootXMLElement;
    
    if(root!=nil)
    {
        TBXMLElement *results = [TBXML childElementNamed:@"results" parentElement:root];
        if(results!=nil)
        {
            TBXMLElement *result = [TBXML childElementNamed:@"result" parentElement:results];
            
            while (result!=nil) {
                
                TBXMLElement *_id = [TBXML childElementNamed:@"objid" parentElement:result];
                TBXMLElement *_type = [TBXML childElementNamed:@"type" parentElement:result];
                TBXMLElement *_title = [TBXML childElementNamed:@"title" parentElement:result];
                TBXMLElement *_url = [TBXML childElementNamed:@"url" parentElement:result];
                TBXMLElement *_author = [TBXML childElementNamed:@"author" parentElement:result];
                
                ResultMsg *msg = [[ResultMsg alloc] initContent:[TBXML textForElement:_id] andType:[TBXML textForElement:_type] andTitle:[TBXML textForElement:_title] andUrl:[TBXML textForElement:_url] andAuthor:[TBXML textForElement:_author]];
                
                [array addObject:msg];
                
                result = [TBXML nextSiblingNamed:@"result" searchFromElement:result];
            }
            
        }
    }
    
    return array;
}

@end
