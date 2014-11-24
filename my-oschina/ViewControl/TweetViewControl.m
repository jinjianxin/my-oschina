//
//  TweetViewControl.m
//  my-oschina
//
//  Created by jjx on 14/11/5.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "TweetViewControl.h"

@implementation TweetViewControl
{
    id<TabBarProtocol> mydelegate;
    TweetCell *customCell;
}

@synthesize pullTableView;
@synthesize m_uid;
@synthesize m_newsArray;
@synthesize m_countPage;
@synthesize isLoadOver;
@synthesize projectId;
@synthesize newsCategory;
@synthesize body;

- (void)loadView
{
    [super loadView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAttachmentCommentCount:) name:@"soft_count" object:nil];
    
    isLoadOver = NO;
    
    self.pullTableView.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
    self.pullTableView.pullBackgroundColor = [UIColor whiteColor];
    self.pullTableView.pullTextColor = [UIColor blackColor];
    self.pullTableView.pullDelegate = self;
    
    pullTableView.dataSource = self;
    pullTableView.delegate = self;
    
    
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    m_uid = 0;
    
    m_newsArray = [[NSMutableArray alloc] initWithCapacity:2];
}

- (void)getAttachmentCommentCount:(NSNotification *)notification
{
    if (notification.object)
    {
        NSMutableArray *nc = (NSMutableArray *)notification.object;
        if (nc)
        {
            
            if([nc objectAtIndex:0] == self.body)
            {
                self.projectId = [nc objectAtIndex:2] ;
            }
        }
    }
}

-(void)setMyDelegate:(id<TabBarProtocol>)delegate
{
    mydelegate =delegate;
}

-(void)barButttonClick
{
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadContent];
}

- (void) loadContent
{
    int count = (int)[m_newsArray count]/20;
    m_countPage = count;
    
    NSString *str = nil;
    
    if(self.newsCategory ==100)
    {
        str = @"http://www.oschina.net/action/api/software_tweet_list?project=33477";
    }
    else{
        str = [NSString stringWithFormat:@"%@uid=%d&pageIndex=%d&pageSize=%d", tweet_url,self.m_uid,count,20];
    }

    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:str]];
    
    [request setDelegate:self];
    [request startAsynchronous];

}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
   
    NSArray *array = [XmlParser tweetNewParser:responseString];
    

    if(array.count<20)
    {
        isLoadOver = YES;
    }

    [m_newsArray addObjectsFromArray:array];
  
    [self.pullTableView reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
}

- (void)refreshTable {
    self.pullTableView.pullLastRefreshDate = [NSDate date];
    self.pullTableView.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable {
    self.pullTableView.pullTableIsLoadingMore = NO;
    
    if(!isLoadOver)
    {
        [self loadContent];
    }
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView {
    [self performSelector:@selector(loadMoreDataToTable)
               withObject:nil
               afterDelay:0.2f];
}

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView {
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0.2f];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_newsArray count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetMsg *msg = [m_newsArray objectAtIndex:[indexPath row]];
    
    
    if(msg!=nil)
    {
        return msg.m_height;
    }
    else{
        return 62;
    }
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 140;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tag = @"tweetCell";
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:tag];
    TweetMsg *msg = [m_newsArray objectAtIndex:[indexPath row]];

    [cell setContent:msg];
    
    return cell;
    
}

- (IBAction)segSender:(id)sender {
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    int index = (int)seg.selectedSegmentIndex;
    
    if(index ==0)
    {
        self.m_uid = 0;
    }
    else if(index ==1)
    {
        self.m_uid = -1;

    }
    else if(index ==2)
    {
        self.m_uid = 0;
    }
    
    [m_newsArray removeAllObjects];
    [pullTableView reloadData];
    
    [self loadContent];
    
}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath :(NSIndexPath *)indexPath
{
 
    TweetMsg *msg = [m_newsArray objectAtIndex:[indexPath row]];
    
    MyUITabBarControl *newTab = [[MyUITabBarControl alloc] init];
    newTab.title = @"动态详情";
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];

    TweetDetailViewControl *tweetDetail = [storyboard instantiateViewControllerWithIdentifier:@"TweetDetailViewControl"];
    tweetDetail.tabBarItem.image = [UIImage imageNamed:@"detail"];
    tweetDetail.tabBarItem.title = @"咨询详情";
    tweetDetail.m_uid = msg.m_id;
    
    CommentsDetail *commentDetail = [storyboard instantiateViewControllerWithIdentifier:@"CommentsDetail"];
    commentDetail.view.backgroundColor = [UIColor whiteColor];
    commentDetail.tabBarItem.image = [UIImage imageNamed:@"commentlist"];
    commentDetail.tabBarItem.title = @"评论";
    commentDetail.ids = msg.m_id;
    commentDetail.newsCategory = 3;
    [commentDetail setMyDelegate:newTab];


    [tweetDetail viewDidAppear:YES];
    
    newTab.viewControllers = [NSArray arrayWithObjects:tweetDetail,commentDetail,nil];
    newTab.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newTab animated:YES];
    
}

@end
