//
//  TweetViewControl.m
//  my-oschina
//
//  Created by jjx on 14/11/5.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "TweetViewControl.h"

@implementation TweetViewControl {
    id<TabBarProtocol> mydelegate;
    TweetCell* customCell;
}

@synthesize m_pullTableView;
@synthesize m_uid;
@synthesize m_newsArray;
@synthesize m_countPage;
@synthesize m_isLoadOver;
@synthesize m_projectId;
@synthesize m_newsCategory;
@synthesize m_body;

- (void)loadView
{
    [super loadView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAttachmentCommentCount:) name:@"soft_count" object:nil];

    m_isLoadOver = NO;

    self.m_pullTableView.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
    self.m_pullTableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_pullTableView.pullTextColor = [UIColor blackColor];
    self.m_pullTableView.pullDelegate = self;

    m_pullTableView.dataSource = self;
    m_pullTableView.delegate = self;

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    m_uid = 0;

    m_newsArray = [[NSMutableArray alloc] initWithCapacity:2];
}

- (void)getAttachmentCommentCount:(NSNotification*)notification
{
    if (notification.object) {
        NSMutableArray* nc = (NSMutableArray*)notification.object;
        if (nc) {

            if ([nc objectAtIndex:0] == self.m_body) {
                self.m_projectId = [nc objectAtIndex:2];
            }
        }
    }
}

- (void)setMyDelegate:(id<TabBarProtocol>)delegate
{
    mydelegate = delegate;
}

- (void)barButttonClick
{
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self loadContent];
}

- (void)loadContent
{
    int count = (int)[m_newsArray count] / 20;
    m_countPage = count;

    NSString* str = nil;

    if (self.m_newsCategory == 100) {
        str = @"http://www.oschina.net/action/api/software_tweet_list?project=33477";
    }
    else {
        str = [NSString stringWithFormat:@"%@uid=%d&pageIndex=%d&pageSize=%d", tweet_url, self.m_uid, count, 20];
    }

    NSLog(@"%@", str);

    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:str]];

    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest*)request
{
    NSString* responseString = [request responseString];

    NSArray* array = [XmlParser tweetNewParser:responseString];

    if (array.count < 20) {
        m_isLoadOver = YES;
    }

    [m_newsArray addObjectsFromArray:array];

    [self.m_pullTableView reloadData];
}

- (void)requestFailed:(ASIHTTPRequest*)request
{
}

- (void)refreshTable
{
    self.m_pullTableView.pullLastRefreshDate = [NSDate date];
    self.m_pullTableView.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{
    self.m_pullTableView.pullTableIsLoadingMore = NO;

    if (!m_isLoadOver) {
        [self loadContent];
    }
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable)
               withObject:nil
               afterDelay:0.2f];
}

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0.2f];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_newsArray count];
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    TweetMsg* msg = [m_newsArray objectAtIndex:[indexPath row]];

    if (msg != nil) {
        return msg.m_height;
    }
    else {
        return 62;
    }
}

- (CGFloat)tableView:(UITableView*)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath
{

    return 140;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* tag = @"tweetCell";
    static NSString* tagImag = @"tweetCellImg";

    TweetMsg* msg = [m_newsArray objectAtIndex:[indexPath row]];

    if ([msg.m_imgSmall length] != 0) {
        TweetCellImag* cell = [tableView dequeueReusableCellWithIdentifier:tagImag];
        [cell setContent:msg];

        if ([[cell.m_imageView gestureRecognizers] count] > 0) {
            UITip* tip = [[cell.m_imageView gestureRecognizers] objectAtIndex:0];
            tip.m_imageView = cell.m_imageView;
            tip.m_imageUrl = msg.m_imgBig;
        }
        else {
            cell.m_imageView.userInteractionEnabled = YES;

            UITip* tip = [[UITip alloc] initWithTarget:self action:@selector(clickImage:)];
            tip.numberOfTapsRequired = 1;
            tip.m_imageView = cell.m_imageView;
            tip.m_imageUrl = msg.m_imgBig;

            [cell.m_imageView addGestureRecognizer:tip];
        }

        return cell;
    }
    else {
        TweetCell* cell = [tableView dequeueReusableCellWithIdentifier:tag];
        [cell setContent:msg];

        return cell;
    }
}

- (void)clickImage:(id)sender
{
    UITip* tip = (UITip*)sender;

    GGFullscreenImageViewController* viewControl = [[GGFullscreenImageViewController alloc] init];
    viewControl.liftedImageView = tip.m_imageView;
    viewControl.m_imageUrl = tip.m_imageUrl;

    [self presentViewController:viewControl animated:YES completion:nil];
}

- (IBAction)segSender:(id)sender
{
    UISegmentedControl* seg = (UISegmentedControl*)sender;
    int index = (int)seg.selectedSegmentIndex;

    if (index == 0) {
        self.m_uid = 0;
    }
    else if (index == 1) {
        self.m_uid = -1;
    }
    else if (index == 2) {
        self.m_uid = 0;
    }

    [m_newsArray removeAllObjects];
    [m_pullTableView reloadData];

    [self loadContent];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{

    TweetMsg* msg = [m_newsArray objectAtIndex:[indexPath row]];

    MyUITabBarControl* newTab = [[MyUITabBarControl alloc] init];
    newTab.title = @"动态详情";

    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];

    TweetDetailViewControl* tweetDetail = [storyboard instantiateViewControllerWithIdentifier:@"TweetDetailViewControl"];
    tweetDetail.tabBarItem.image = [UIImage imageNamed:@"detail"];
    tweetDetail.tabBarItem.title = @"咨询详情";
    tweetDetail.m_uid = msg.m_id;
    [tweetDetail setMyDelegate:newTab];

    CommentsDetail* commentDetail = [storyboard instantiateViewControllerWithIdentifier:@"CommentsDetail"];
    commentDetail.view.backgroundColor = [UIColor whiteColor];
    commentDetail.tabBarItem.image = [UIImage imageNamed:@"commentlist"];
    commentDetail.tabBarItem.title = @"评论";
    commentDetail.m_ids = msg.m_id;
    commentDetail.m_newsCategory = 3;
    [commentDetail setMyDelegate:newTab];

    [tweetDetail viewDidAppear:YES];

    newTab.viewControllers = [NSArray arrayWithObjects:tweetDetail, commentDetail, nil];
    newTab.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newTab animated:YES];
}

- (IBAction)m_tweetSender:(id)sender
{

    UIStoryboard* stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];

    SubmitTweet* submitTweet = [stroyboard instantiateViewControllerWithIdentifier:@"SubmitTweet"];

    submitTweet.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:submitTweet animated:YES];
}

@end
