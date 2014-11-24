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
            MyUITabBarControl *newTab = [[MyUITabBarControl alloc] init];
            newTab.title = @"资讯详情";
            
            NewDetail* newDetail = [[NewDetail alloc] init];
            newDetail.view.backgroundColor = [UIColor whiteColor];
            newDetail.title = @"资讯";
            newDetail.tabBarItem.title = @"资讯";
            newDetail.tabBarItem.image = [UIImage imageNamed:@"detail"];
            newDetail.newsCategory = category;
            newDetail.msgDetail = msg;
            newDetail.ids = msg.ids;
            [newDetail setMyDelegate:newTab];
            [newDetail viewDidAppear:YES];
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            
            CommentsDetail *commentDetail = [storyboard instantiateViewControllerWithIdentifier:@"CommentsDetail"];
            commentDetail.tabBarItem.title = @"评论";
            commentDetail.view.backgroundColor = [UIColor whiteColor];
            commentDetail.tabBarItem.image = [UIImage imageNamed:@"commentlist"];
            commentDetail.msgDetail = msg;
            commentDetail.newsCategory = category;
            commentDetail.ids = msg.ids;
            [commentDetail setMyDelegate:newTab];
            
            ShareDetail* shareDetail = [[ShareDetail alloc] init];
            shareDetail.tabBarItem.title = @"分享";
            shareDetail.view.backgroundColor = [UIColor whiteColor];
            shareDetail.tabBarItem.image = [UIImage imageNamed:@"share"];
            [shareDetail setMyDelegate:newTab];
            
            newTab.viewControllers = [NSArray arrayWithObjects:newDetail, commentDetail, shareDetail, nil];
            newTab.hidesBottomBarWhenPushed = YES;
            
            [navigationController pushViewController:newTab animated:YES];
        }
            break;
        case 1:
        {
            MyUITabBarControl *newTab = [[MyUITabBarControl alloc] init];
            newTab.title = @"软件详情";
            
            SoftDetail *software = [[SoftDetail alloc] init];
            software.tabBarItem.image = [UIImage imageNamed:@"detail"];
            software.softwareName = msg.attachMent;
            [software viewDidAppear:YES];
            
             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            
            TweetViewControl *tweetView =  [storyboard instantiateViewControllerWithIdentifier:@"TweetViewControl"];
            tweetView.tabBarItem.title = @"评论";
            tweetView.view.backgroundColor = [UIColor whiteColor];
            tweetView.tabBarItem.image = [UIImage imageNamed:@"commentlist"];
            tweetView.newsCategory = 100;
            tweetView.body  = software;
            [tweetView setMyDelegate:newTab];
            
            
            ShareDetail* shareDetail = [[ShareDetail alloc] init];
            shareDetail.tabBarItem.title = @"分享";
            shareDetail.view.backgroundColor = [UIColor whiteColor];
            shareDetail.tabBarItem.image = [UIImage imageNamed:@"share"];
            [shareDetail setMyDelegate:newTab];

            
            newTab.viewControllers = [NSArray arrayWithObjects:software, tweetView, shareDetail, nil];
            newTab.hidesBottomBarWhenPushed = YES;
            
            [navigationController pushViewController:newTab animated:YES];

        }
            break;
        case 2:
        {
            
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
            
            CommentsDetail* commentDetail = [[CommentsDetail alloc] init];
            commentDetail.tabBarItem.title = @"评论";
            commentDetail.view.backgroundColor = [UIColor whiteColor];
            commentDetail.tabBarItem.image = [UIImage imageNamed:@"commentlist"];
            commentDetail.msgDetail = msg;
            commentDetail.newsCategory = 5;
            commentDetail.parentID = [msg.attachMent intValue];
            commentDetail.ids = msg.ids;
            [commentDetail setMyDelegate:newTab];
            
            ShareDetail* shareDetail = [[ShareDetail alloc] init];
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

@end
