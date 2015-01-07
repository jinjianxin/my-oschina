//
//  SubmitQuestion.h
//  my-oschina
//
//  Created by jjx on 14/11/24.
//  Copyright (c) 2014年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "prefix_define.h"
#import "Helper.h"
#import "TBXML.h"

@interface SubmitQuestion : UIViewController <ASIHTTPRequestDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField* m_title;
- (IBAction)m_segSender:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView* m_contentView;
- (IBAction)m_switchSender:(id)sender;

@property int m_newCategory;

@end
