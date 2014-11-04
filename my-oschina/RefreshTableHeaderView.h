//
//  RefreshTableHeaderView.h
//  my-oschina
//
//  Created by jjx on 14/11/4.
//  Copyright (c) 2014年 jjx. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
    OPullRefreshPulling = 0,
    OPullRefreshNormal,
    OPullRefreshLoading,
}PullRefreshState;

@protocol RefreshTableHeaderDelegate;
@interface RefreshTableHeaderView : UIView {
    
    id _delegate;
    PullRefreshState _state;
    
    UILabel *_lastUpdatedLabel;
    UILabel *_statusLabel;
    CALayer *_arrowImage;
    UIActivityIndicatorView *_activityView;
    
    
}

@property(nonatomic,assign) id <RefreshTableHeaderDelegate> delegate;

- (void)refreshLastUpdatedDate;
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end
@protocol RefreshTableHeaderDelegate
- (void)egoRefreshTableHeaderDidTriggerRefresh:(RefreshTableHeaderView*)view;
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(RefreshTableHeaderView*)view;
@optional
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(RefreshTableHeaderView*)view;
@end