//
//  ListViewController.h
//  Apple Hot News
//
//  Created by oleksandr on 15.10.14.
//  Copyright (c) 2014 Access Softek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSSChannel;
@class RSSItem;
@class WebViewController;

@interface ListViewController : UITableViewController <NSXMLParserDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    
    RSSChannel *channel;
}
@property (nonatomic, retain) WebViewController *webViewController;
@end