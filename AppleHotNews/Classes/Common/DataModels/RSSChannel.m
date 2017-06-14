//
//  RSSChannel.m
//  Apple Hot News
//
//  Created by oleksandr on 15.10.14.
//  Copyright (c) 2014 Access Softek. All rights reserved.
//

#import "RSSChannel.h"
#import "RSSItem.h"

@implementation RSSChannel

#pragma mark - Life cycle

- (id)init
{
    self = [super init];
    if (self)
    {
        _itemsStore = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)dealloc
{
    [_title release];
    [_itemsStore release];
    _title = nil;
    _itemsStore = nil;
    [super dealloc];
}

#pragma mark - Setters

-(void)setTitle:(NSString *)title
{
    if (_title != title)
    {
        [_title release];
        [title retain];
        _title = title;
    }
}

@end
