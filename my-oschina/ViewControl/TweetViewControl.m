//
//  TweetViewControl.m
//  my-oschina
//
//  Created by jjx on 14/11/5.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "TweetViewControl.h"

@implementation TweetViewControl

@synthesize pullTableView;
@synthesize m_uid;
@synthesize m_newsArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadContent];
}

- (void) loadContent
{
    int count = (int)[m_newsArray count]/20;
    
    NSString *str = [NSString stringWithFormat:@"%@uid=%d&pageIndex=%d&pageSize=%d", tweet_url,self.m_uid,count,20];
    NSLog(@"str = %@",str);
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:str]];
    
    [request setDelegate:self];
    [request startAsynchronous];

}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
   
    NSArray *array = [XmlParser tweetNewParser:responseString];
    
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
    
    [self loadContent];
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tag = @"tag";
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:tag];
    
    if(cell ==nil)
    {
        cell = [[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tag];
    }
    
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
@end
