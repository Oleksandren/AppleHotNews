//
//  RSSItem.m
//  Apple Hot News
//
//  Created by oleksandr on 15.10.14.
//  Copyright (c) 2014 Access Softek. All rights reserved.
//

#import "RSSItem.h"

@implementation RSSItem

#pragma mark - Life cycle

-(void)dealloc
{
    [_detail release];
    [_title release];
    [_link release];
    _detail = nil;
    _title = nil;
    _link = nil;
    [super dealloc];
}

#pragma mark - Setters

-(void)setTitle:(NSString *)title
{
    if (_title != title)
    {
        [title retain];
        [_title release];
        _title = title;
    }
}

-(void)setDetail:(NSString *)detail
{
    if (_detail != detail)
    {
        [detail retain];
        [_detail release];
        _detail = detail;
    }
}

-(void)setLink:(NSString *)link
{
    if (_link !=link)
    {
        [link retain];
        [_link release];
        _link = link;
    }
}

@end
