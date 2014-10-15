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
    [super dealloc];
    _detail = nil;
    _title = nil;
    _link = nil;
}

#pragma mark - NSXMLParser Delegate

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    currentString = [[NSMutableString alloc] init];
    if ([elementName isEqual:@"title"])
    {
        [self setTitle:currentString];
    }
    else if ([elementName isEqual:@"link"])
    {
        [self setLink:currentString];
    }
    else if ([elementName isEqual:@"description"])
    {
        [self setDetail:currentString];
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
    if ([elementName isEqualToString:@"pubDate"])
        [parser setDelegate:_parentParserDelegate];
    currentString = nil;
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