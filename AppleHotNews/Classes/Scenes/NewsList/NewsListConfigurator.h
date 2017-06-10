//
//  NewsListConfigurator.h
//  AppleHotNews
//
//  Created by Oleksandr Nechet on 08.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsListViewController;

@interface NewsListConfigurator: NSObject
+ (void)configureView:(NewsListViewController *) view;
@end
