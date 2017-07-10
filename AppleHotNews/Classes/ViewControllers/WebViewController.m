//
//  WebViewController.m
//  Apple Hot News
//
//  Created by oleksandr on 15.10.14.
//  Copyright (c) 2014 Access Softek. All rights reserved.
//

#import "WebViewController.h"
#import "RSSItem.h"

@implementation WebViewController

#pragma mark - Life cycle

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
        UIWebView *wv = [[UIWebView alloc] initWithFrame:screenFrame];
        wv.delegate = self;
        [wv setScalesPageToFit:YES];
        [self setView:wv];
    }
    return self;
}

-(void)dealloc
{
    [_item release];
    _item = nil;
    [super dealloc];
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
        show_hud(self.webView);
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
    hide_hud(self.webView);
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    hide_hud(self.webView);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Could not load page"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
    [alertView release];
}

#pragma mark - UISplitViewController Delegate

-(BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return NO;
}

@end
