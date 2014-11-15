//
//  SearchViewController.h
//  my-oschina
//
//  Created by jjx on 14/11/12.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "prefix_define.h"
#import "ASIFormDataRequest.h"
#import "XmlParser.h"
#import "CommentsDetail.h"
#import "NewDetail.h"
#import "ShareDetail.h"

@interface SearchViewController : UIViewController  <UITabBarDelegate,UITableViewDataSource,UISearchBarDelegate,ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property (strong,nonatomic) UITableView *m_tableView;
@property (strong,nonatomic) UISearchBar *m_searchBar;
@property int m_category;


@property (strong,nonatomic) NSMutableArray *m_resultArray;
@property BOOL m_isLoading;
@property BOOL m_isLoadOver;

@end
