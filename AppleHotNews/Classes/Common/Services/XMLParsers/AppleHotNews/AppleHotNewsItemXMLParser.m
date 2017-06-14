//
//  AppleHotNewsItemXMLParser.m
//  AppleHotNews
//
//  Created by Oleksandr Nechet on 08.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

#import "AppleHotNewsItemXMLParser.h"
#import "RSSItem.h"

@interface AppleHotNewsItemXMLParser ()
{
    NSMutableString *currentParsedString;
}
@end

@implementation AppleHotNewsItemXMLParser

#pragma mark: - Object lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _item = [RSSItem new];
    }
    
    return self;
}

- (void)dealloc
{
    [_item release];
    [super dealloc];
}


#pragma mark - NSXMLParser Delegate

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    currentParsedString = [[NSMutableString alloc] init];
    if ([elementName isEqual:@"title"])
    {
        [_item setTitle:currentParsedString];
    }
    else if ([elementName isEqual:@"link"])
    {
        [_item setLink:currentParsedString];
    }
    else if ([elementName isEqual:@"description"])
    {
        [_item setDetail:currentParsedString];
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
    if ([elementName isEqualToString:@"pubDate"])
        [parser setDelegate:_parentParserDelegate];
    [currentParsedString release];
    currentParsedString = nil;
}
@end
