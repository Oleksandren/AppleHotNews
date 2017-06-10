//
//  NewsListConfigurator.m
//  AppleHotNews
//
//  Created by Oleksandr Nechet on 08.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

#import "NewsListConfigurator.h"
#import "NewsListViewController.h"
#import "NewsListViewModel.h"
#import "NetworkLayer.h"
#import "XMLParser.h"


@implementation NewsListConfigurator

+ (void)configureView:(NewsListViewController *)view
{
    NewsListViewModel *viewModel = [[NewsListViewModel alloc] initWithNetworkLayer:[NetworkLayer shared]];
    view.viewModel = viewModel;
    [viewModel release];
}

@end
