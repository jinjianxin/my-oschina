//
//  SearchViewController.m
//  my-oschina
//
//  Created by jjx on 14/11/12.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize m_category;
@synthesize m_resultArray;
@synthesize m_isLoading;
@synthesize m_isLoadOver;
@synthesize m_searchBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    m_resultArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    m_isLoading = NO;
    m_isLoadOver = NO;
    
    NSArray *segmentTextContent = [NSArray arrayWithObjects:@"搜软件", @"搜问答",@"搜博客",@"搜资讯" ,nil];
    
    UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
    segControl.selectedSegmentIndex =0;
    segControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    segControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segControl.frame = CGRectMake(0, 0, 300, 30);
    self.navigationItem.titleView = segControl;
    [segControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //在这里创建搜索栏和搜索显示控制器
    m_searchBar.delegate =self;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    tap.delegate = self;
    
    [self.view addGestureRecognizer:tap];

}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        
      //  [m_searchBar resignFirstResponder];
        return NO;
    }
    return  YES;
}

- (void)dismissKeyboard {
    //[m_searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
     NSLog(@"%@",searchBar.text);
    
    [self searchKeyResult:nil];
}

- (void)searchKeyResult:(NSString*)key
{
    NSString* category = nil;

    if (m_category == 0) {
        category = @"software";
    }
    else if (m_category == 1) {
        category = @"post";
    }
    else if (m_category == 2) {
        category = @"blog";
    }
    else if (m_category == 3) {
        category = @"news";
    }
    
    m_isLoading = YES;
    
    NSString *postURL = [NSString stringWithFormat:@"%@", api_search_list];
    
    int page = (int) [m_resultArray count]/20;
    NSString *value = m_searchBar.text;
    
    
    ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:postURL]];
    
    [request setPostValue:@"20" forKey:@"pageSize"];
    [request setPostValue:value forKey:@"content"];
    [request setPostValue:category forKey:@"catalog"];
    [request setPostValue:[NSString stringWithFormat:@"%d",page] forKey:@"pageIndex"];
    
    [request setDelegate:self];
    [request startSynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *response = request.responseString;
    NSArray *array = [XmlParser searchResultParser:response];
    
    if(array.count<20)
    {
        m_isLoadOver = YES;
    }
    
    [m_resultArray addObjectsFromArray:array];
    
    m_isLoading = NO;
    
    [self.m_tableView reloadData];
    
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    
}

- (void)segmentAction:(id)sender
{
    UISegmentedControl *segControl = (UISegmentedControl*)sender;
    m_category = (int) segControl.selectedSegmentIndex;
    
    [m_resultArray removeAllObjects];
    
   // [m_tableView reloadData];
    
    [self searchKeyResult:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(m_isLoading)
    {
        return [self.m_resultArray count];
    }
    else{
        
        if([m_resultArray count] ==0)
        {
            return 0;
        }
        else{
            
            if(m_isLoadOver)
            {
                 return [self.m_resultArray count];
            }
            else{
            
                return [self.m_resultArray count]+1;
            }
        }
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{

    if(m_resultArray.count>0)
    {
        if (indexPath.row < m_resultArray.count) {
            static NSString* tag = @"tag";
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:tag];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tag];
            }
            
            if ([m_resultArray count] == 0) {
            }
            else {
                
                int index = (int)[indexPath row];
                
                if (index == [m_resultArray count]) {
                    
                    cell.textLabel.text = @"点击加载更多";
                }
                else {
                    
                    ResultMsg* msg = [m_resultArray objectAtIndex:[indexPath row]];
                    
                    cell.textLabel.text = msg.m_title;
                }
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return cell;
        }
        else {
            static NSString* tag = @"tag";
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:tag];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tag];
            }
            
            cell.textLabel.text = @"点击加载更多";
            
            return cell;
        }
    }
    else{
        static NSString* tag = @"tag";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:tag];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tag];
        }
        
        cell.textLabel.text = @"无结果";
        
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int index = (int)[indexPath row];
    
    if(index == (int)[m_resultArray count])
    {
        [self searchKeyResult:nil];
    }
    else{
        
        ResultMsg *msg = [m_resultArray objectAtIndex:[indexPath row]];
        
        MyUITabBarControl *newTab = [[MyUITabBarControl alloc] init];
        
        
        NewDetail* newDetail = [[NewDetail alloc] init];
        newDetail.view.backgroundColor = [UIColor whiteColor];
        newDetail.title = @"资讯";
        newDetail.tabBarItem.title = @"资讯";
        newDetail.tabBarItem.image = [UIImage imageNamed:@"detail"];
        newDetail.newsCategory = 1;
        newDetail.ids = msg.m_id;
        [newDetail setMyDelegate:newTab];

        
        UIStoryboard *stroboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        CommentsDetail* commentDetail = [stroboard instantiateViewControllerWithIdentifier:@"CommentsDetail"];
        commentDetail.tabBarItem.title = @"评论";
        commentDetail.view.backgroundColor = [UIColor whiteColor];
        commentDetail.tabBarItem.image = [UIImage imageNamed:@"commentlist"];
        commentDetail.newsCategory = 1;
        commentDetail.ids = msg.m_id;
        [commentDetail setMyDelegate:newTab];
        
        ShareDetail* shareDetail = [stroboard instantiateViewControllerWithIdentifier:@"ShareDetail"];
        shareDetail.tabBarItem.title = @"分享";
        shareDetail.view.backgroundColor = [UIColor whiteColor];
        shareDetail.tabBarItem.image = [UIImage imageNamed:@"share"];
        [shareDetail setMyDelegate:newTab];
        
        [newDetail viewDidAppear:YES];
        
        newTab.viewControllers = [NSArray arrayWithObjects:newDetail,commentDetail,shareDetail, nil];
        
        [self.navigationController pushViewController:newTab animated:YES];
        
    }
}


@end
