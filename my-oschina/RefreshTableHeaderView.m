//
//  RefreshTableHeaderView.m
//  my-oschina
//
//  Created by jjx on 14/11/4.
//  Copyright (c) 2014年 jjx. All rights reserved.
//


#import "RefreshTableHeaderView.h"


#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f


@interface RefreshTableHeaderView (Private)
- (void)setState:(PullRefreshState)aState;
@end

@implementation RefreshTableHeaderView

@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textColor = TEXT_COLOR;
        label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        [self addSubview:label];
        _lastUpdatedLabel=label;
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont boldSystemFontOfSize:13.0f];
        label.textColor = TEXT_COLOR;
        label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        [self addSubview:label];
        _statusLabel=label;
        [label release];
        
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(25.0f, frame.size.height - 65.0f, 30.0f, 55.0f);
        layer.contentsGravity = kCAGravityResizeAspect;
        layer.contents = (id)[UIImage imageNamed:@"blueArrow.png"].CGImage;
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            layer.contentsScale = [[UIScreen mainScreen] scale];
        }
#endif
        
        [[self layer] addSublayer:layer];
        _arrowImage=layer;
        
        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        view.frame = CGRectMake(25.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
        [self addSubview:view];
        _activityView = view;
        [view release];
        
        
        [self setState:OPullRefreshNormal];
        
    }
    
    return self;
    
}


#pragma mark -
#pragma mark Setters

- (void)refreshLastUpdatedDate {
    
    if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceLastUpdated:)]) {
        
        NSDate *date = [_delegate egoRefreshTableHeaderDataSourceLastUpdated:self];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setAMSymbol:@"AM"];
        [formatter setPMSymbol:@"PM"];
        [formatter setDateFormat:@"MM/dd/yyyy hh:mm:a"];
        _lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [formatter stringFromDate:date]];
        [[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [formatter release];
        
    } else {
        
        _lastUpdatedLabel.text = nil;
        
    }
    
}

- (void)setState:(PullRefreshState)aState{
    
    switch (aState) {
        case OPullRefreshPulling:
            
            _statusLabel.text = NSLocalizedString(@"Release to refresh...", @"Release to refresh status");
            [CATransaction begin];
            [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
            _arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
            [CATransaction commit];
            
            break;
        case OPullRefreshNormal:
            
            if (_state == OPullRefreshPulling) {
                [CATransaction begin];
                [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
                _arrowImage.transform = CATransform3DIdentity;
                [CATransaction commit];
            }
            
            _statusLabel.text = NSLocalizedString(@"Pull down to refresh...", @"Pull down to refresh status");
            [_activityView stopAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            _arrowImage.hidden = NO;
            _arrowImage.transform = CATransform3DIdentity;
            [CATransaction commit];
            
            [self refreshLastUpdatedDate];
            
            break;
        case OPullRefreshLoading:
            
            _statusLabel.text = NSLocalizedString(@"Loading...", @"Loading Status");
            [_activityView startAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            _arrowImage.hidden = YES;
            [CATransaction commit];
            
            break;
        default:
            break;
    }
    
    _state = aState;
}


#pragma mark -
#pragma mark ScrollView Methods

- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_state == OPullRefreshLoading) {
        
        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
        offset = MIN(offset, 60);
        scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
        
    } else if (scrollView.isDragging) {
        
        BOOL _loading = NO;
        if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
            _loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
        }
        
        if (_state == OPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_loading) {
            [self setState:OPullRefreshNormal];
        } else if (_state == OPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_loading) {
            [self setState:OPullRefreshPulling];
        }
        
        if (scrollView.contentInset.top != 0) {
            scrollView.contentInset = UIEdgeInsetsZero;
        }
        
    }
    
}

- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    
    BOOL _loading = NO;
    if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
        _loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
    }
    
    if (scrollView.contentOffset.y <= - 65.0f && !_loading) {
        
        if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:)]) {
            [_delegate egoRefreshTableHeaderDidTriggerRefresh:self];
        }
        
        [self setState:OPullRefreshLoading];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        [UIView commitAnimations];
        
    }
    
}

- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {	
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    [scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    [UIView commitAnimations];
    
    [self setState:OPullRefreshNormal];
    
}


#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
    
    _delegate=nil;
    _activityView = nil;
    _statusLabel = nil;
    _arrowImage = nil;
    _lastUpdatedLabel = nil;
    [super dealloc];
}

@end
