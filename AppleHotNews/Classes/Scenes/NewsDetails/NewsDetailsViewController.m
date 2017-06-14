//
//  WebViewController.m
//  Apple Hot News
//
//  Created by oleksandr on 15.10.14.
//  Copyright (c) 2014 Access Softek. All rights reserved.
//

#import "NewsDetailsViewController.h"
#import "RSSItem.h"
#import "ActivityIndicatorManager.h"
#import "UIViewController+Alert.h"
#import "Constants.h"

@implementation NewsDetailsViewController

#pragma mark - Life cycle

-(void)dealloc
{
    [_item release];
    _item = nil;
    [super dealloc];
}

- (void)loadView
{
    UIWebView *webView = [UIWebView new];
    webView.delegate = self;
    [webView setScalesPageToFit:YES];
    [self setView:webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

#pragma mark - Assets

- (UIWebView *)webView
{
    return [[(UIWebView *)[self view] retain] autorelease];
}

- (void)setItem:(RSSItem *)item
{
    if (_item != item)
    {
        [ActivityIndicatorManager showHUD];
        [_item release];
        [item retain];
        _item = item;
     
        NSURL *url = [NSURL URLWithString:[[_item link] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        [[self webView] loadRequest:req];
        [[self navigationItem] setTitle:[item title]];
    }
}

#pragma mark - UIWebView Delegate

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
     [ActivityIndicatorManager hideHUD];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [ActivityIndicatorManager hideHUD];
    [self displayAlertWithTitle:couldNotLoadPage
                        message:[error localizedDescription]];
}

#pragma mark - UISplitViewController Delegate

-(BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return NO;
}

@end
