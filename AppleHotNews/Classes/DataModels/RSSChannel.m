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

#pragma mark - NSXMLParser Delegate

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqual:@"title"])
    {
        currentString = [[NSMutableString alloc] init];
        [self setTitle:currentString];
    }
    else if ([elementName isEqual:@"item"])
    {
        currentItem = [[RSSItem alloc] init];
        [currentItem setParentParserDelegate:self];
        [parser setDelegate:currentItem];
    }
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)str
{
    [currentString appendString:str];
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    [currentString release];
    currentString = nil;
    
    if ([elementName isEqual:@"channel"])
        [parser setDelegate:_parentParserDelegate];
    if ([elementName isEqual:@"item"])
        [_itemsStore addObject:currentItem];
}

@end
