//
//  NewsXMLParser.m
//  AppleHotNews
//
//  Created by Oleksandr Nechet on 08.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

#import "AppleHotNewsChanelXMLParser.h"
#import "AppleHotNewsItemXMLParser.h"
#import "RSSChannel.h"
#import "RSSItem.h"

@interface AppleHotNewsChanelXMLParser ()
{
    NSMutableString *currentParsedString;
    AppleHotNewsItemXMLParser *itemParser;
}
@end

@implementation AppleHotNewsChanelXMLParser

#pragma mark: - Object lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _channel = [RSSChannel new];
    }
    
    return self;
}

- (void)dealloc
{
    [_channel release];
    [super dealloc];
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
        currentParsedString = [[NSMutableString alloc] init];
        [_channel setTitle:currentParsedString];
    }
    else if ([elementName isEqual:@"item"])
    {
        itemParser = [AppleHotNewsItemXMLParser new];
        [itemParser setParentParserDelegate: self];
        [parser setDelegate:itemParser];
    }
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)str
{
    [currentParsedString appendString:str];
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    [currentParsedString release];
    currentParsedString = nil;
    
    if ([elementName isEqual:@"channel"])
        [parser setDelegate:_parentParserDelegate];
    if ([elementName isEqual:@"item"])
        [_channel.itemsStore addObject:itemParser.item];
    [itemParser release];
    itemParser = nil;
}

@end
