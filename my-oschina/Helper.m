//
//  Helper.m
//  my-oschina
//
//  Created by jjx on 14/11/17.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (void)pushNewsDetail:(UINavigationController *)navigationController andMag:(MsgDetail *)msg andCategory:(int)category
{

    switch (msg.newType) {
        case 0:
        {
            [self pushNews:navigationController andIds:msg.m_ids andCategory:category];
        }
            break;
        case 1:
        {
            [self pushSoft:navigationController andIds:msg.attachMent andCategory:0];

        }
            break;
        case 2:
        {
            [self pushQuestion:navigationController andIds:msg.m_ids andCategory:2];
        }
            break;
        case 3:
        {
            MyUITabBarControl *newTab = [[MyUITabBarControl alloc] init];
            newTab.title = @"资讯详情";
        
            
            BlogDetail *blogDetail = [[BlogDetail alloc] init];
            blogDetail.view.backgroundColor = [UIColor whiteColor];
            blogDetail.title = @"资讯";
            blogDetail.tabBarItem.title = @"资讯";
            blogDetail.tabBarItem.image = [UIImage imageNamed:@"detail"];
            blogDetail.newsCategory = category;
            blogDetail.ids = [msg.attachMent intValue];
            [blogDetail setMyDelegate:newTab];
            [blogDetail viewDidAppear:YES];
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            
            CommentsDetail *commentDetail = [storyboard instantiateViewControllerWithIdentifier:@"CommentsDetail"];
            commentDetail.tabBarItem.title = @"评论";
            commentDetail.view.backgroundColor = [UIColor whiteColor];
            commentDetail.tabBarItem.image = [UIImage imageNamed:@"commentlist"];
            commentDetail.m_msgDetail = msg;
            commentDetail.m_newsCategory = 5;
            commentDetail.m_parentID = [msg.attachMent intValue];
            commentDetail.m_ids = msg.m_ids;
            [commentDetail setMyDelegate:newTab];
            
            
            ShareDetail *shareDetail = [storyboard instantiateViewControllerWithIdentifier:@"ShareDetail"];
            shareDetail.tabBarItem.title = @"分享";
            shareDetail.view.backgroundColor = [UIColor whiteColor];
            shareDetail.tabBarItem.image = [UIImage imageNamed:@"share"];
            [shareDetail setMyDelegate:newTab];
            
            newTab.viewControllers = [NSArray arrayWithObjects:blogDetail, commentDetail, shareDetail, nil];
            newTab.hidesBottomBarWhenPushed = YES;
            
            [navigationController pushViewController:newTab animated:YES];

        }
            break;
        default:
            break;
    }
}

+ (void)pushNews:(UINavigationController *)navigationController andIds:(NSString *)ids andCategory:(int)category
{
    MyUITabBarControl *newTab = [[MyUITabBarControl alloc] init];
    newTab.title = @"资讯详情";
    
    NewDetail* newDetail = [[NewDetail alloc] init];
    newDetail.view.backgroundColor = [UIColor whiteColor];
    newDetail.title = @"资讯";
    newDetail.tabBarItem.title = @"资讯";
    newDetail.tabBarItem.image = [UIImage imageNamed:@"detail"];
    newDetail.m_newsCategory = category;
    newDetail.m_ids = ids;
    [newDetail setMyDelegate:newTab];
    [newDetail viewDidAppear:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    CommentsDetail *commentDetail = [storyboard instantiateViewControllerWithIdentifier:@"CommentsDetail"];
    commentDetail.tabBarItem.title = @"评论";
    commentDetail.view.backgroundColor = [UIColor whiteColor];
    commentDetail.tabBarItem.image = [UIImage imageNamed:@"commentlist"];
    commentDetail.m_newsCategory = category;
    commentDetail.m_ids = ids;
    [commentDetail setMyDelegate:newTab];
    
    ShareDetail *shareDetail = [storyboard instantiateViewControllerWithIdentifier:@"ShareDetail"];
    shareDetail.tabBarItem.title = @"分享";
    shareDetail.view.backgroundColor = [UIColor whiteColor];
    shareDetail.tabBarItem.image = [UIImage imageNamed:@"share"];
    [shareDetail setMyDelegate:newTab];
    
    newTab.viewControllers = [NSArray arrayWithObjects:newDetail, commentDetail, shareDetail, nil];
    newTab.hidesBottomBarWhenPushed = YES;
    
    [navigationController pushViewController:newTab animated:YES];

}

+ (void)pushQuestion:(UINavigationController *)navigationController andIds:(NSString *)ids andCategory:(int)category
{
    MyUITabBarControl *newTab = [[MyUITabBarControl alloc] init];
    newTab.title = @"问答详情";
    
    
    PostDetails *postDetail = [[PostDetails alloc] init];
    postDetail.view.backgroundColor = [UIColor whiteColor];
    postDetail.tabBarItem.title = @"详情";
    postDetail.tabBarItem.image = [UIImage imageNamed:@"detail"];
    postDetail.ids = ids ;
    [postDetail setMyDelegate:newTab];
    
    UIStoryboard *stroboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    CommentsDetail *commentDetail = [stroboard instantiateViewControllerWithIdentifier:@"CommentsDetail"];
    commentDetail.view.backgroundColor = [UIColor whiteColor];
    commentDetail.tabBarItem.image = [UIImage imageNamed:@"commentlist"];
    commentDetail.tabBarItem.title = @"评论";
    commentDetail.m_ids = ids;
    commentDetail.m_newsCategory = category;
    [commentDetail setMyDelegate:newTab];
    
    
    ShareDetail *shareDetail = [stroboard instantiateViewControllerWithIdentifier:@"ShareDetail"];
    shareDetail.tabBarItem.title=@"分享";
    shareDetail.view.backgroundColor = [UIColor whiteColor];
    shareDetail.tabBarItem.image = [UIImage imageNamed:@"share"];
    [shareDetail setMyDelegate:newTab];
    
    ReportViewControl *reportView = [[ReportViewControl alloc] init];
    reportView.tabBarItem.title=@"举报";
    reportView.view.backgroundColor = [UIColor whiteColor];
    reportView.tabBarItem.image = [UIImage imageNamed:@"share"];
    [reportView setMyDelegate:newTab];
    
    [postDetail viewDidAppear:YES];
    
    newTab.viewControllers = [NSArray arrayWithObjects:postDetail,commentDetail,shareDetail,reportView, nil];
    newTab.hidesBottomBarWhenPushed = YES;
    [navigationController pushViewController:newTab animated:YES];
}

+ (void)pushSoft:(UINavigationController *)navigationController andIds:(NSString *)ids andCategory:(int)category
{
    MyUITabBarControl *newTab = [[MyUITabBarControl alloc] init];
    newTab.title = @"软件详情";
    
    SoftDetail *software = [[SoftDetail alloc] init];
    software.tabBarItem.image = [UIImage imageNamed:@"detail"];
    software.softwareName = ids;
    [software viewDidAppear:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    TweetViewControl *tweetView =  [storyboard instantiateViewControllerWithIdentifier:@"TweetViewControl"];
    tweetView.tabBarItem.title = @"评论";
    tweetView.view.backgroundColor = [UIColor whiteColor];
    tweetView.tabBarItem.image = [UIImage imageNamed:@"commentlist"];
    tweetView.newsCategory = 100;
    tweetView.body  = software;
    [tweetView setMyDelegate:newTab];
    tweetView.m_top.constant = 64;
    
    
    ShareDetail *shareDetail = [storyboard instantiateViewControllerWithIdentifier:@"ShareDetail"];
    shareDetail.tabBarItem.title = @"分享";
    shareDetail.view.backgroundColor = [UIColor whiteColor];
    shareDetail.tabBarItem.image = [UIImage imageNamed:@"share"];
    [shareDetail setMyDelegate:newTab];
    
    
    newTab.viewControllers = [NSArray arrayWithObjects:software, tweetView, shareDetail, nil];
    newTab.hidesBottomBarWhenPushed = YES;
    
    [navigationController pushViewController:newTab animated:YES]; 
}

+ (void)analysisDetail:(NSString *)url andNav:(UINavigationController *)navigationController
{
    NSLog(@"url = %@",url);
    
    NSString *search = @"oschina.net";
    
    NSRange rng = [url rangeOfString:search];
    if (rng.length <= 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        return;
    }
    else{
        NSString *tail = [url substringFromIndex:7];
        
        if([tail hasPrefix:@"www"])
        {
            NSArray *array = [tail componentsSeparatedByString:@"/"];
           
            if([[array objectAtIndex:1] isEqualToString:@"news"])
            {
                [self pushNews:navigationController andIds:[array objectAtIndex:2] andCategory:1];
                return;
            }
            else if([[array objectAtIndex:1] isEqualToString:@"p"])
            {
                [self pushSoft:navigationController andIds:[array objectAtIndex:2] andCategory:0];
                return;
            }
            else if([[array objectAtIndex:1] isEqualToString:@"question"])
            {
                //[self pushQuestion:navigationController andIds:[array objectAtIndex:2] andCategory:2];
                
                if([array count]==3)
                {
                    NSString *ids = [[[array objectAtIndex:2] componentsSeparatedByString:@"_"] objectAtIndex:1];
                    
                    [self pushQuestion:navigationController andIds:ids andCategory:2];
                    return;
                }
            }
           
        }

    }
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

    
    
    
}

+ (NSString *)getUid
{
    
    NSUserDefaults* userData = [NSUserDefaults standardUserDefaults];
    NSString* uid = [userData stringForKey:@"uid"];

    if (uid != nil) {
        return uid;
    }
    else{
        return nil;
    }

}

@end
