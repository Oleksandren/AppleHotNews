//
//  XMLParser.m
//  AppleHotNews
//
//  Created by Oleksandr Nechet on 08.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

#import "XMLParser.h"
#import "AppleHotNewsChanelXMLParser.h"
#import "RSSChannel.h"

@interface XMLParser()
{
    AppleHotNewsChanelXMLParser *channelParser;
}
@end

@implementation XMLParser

- (instancetype)initWithData:(NSData *)data
                  completion:(XMLParserCompletionHandler)completionHandler
{
    self = [super init];
    if (self) {
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        [parser setDelegate:self];
        [parser parse];
        [parser release];
        completionHandler(channelParser.channel);
        [channelParser release];
    }
    
    return self;
}

#pragma mark - NSXMLParser Delegate

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqual:@"channel"])
    {
        channelParser = [AppleHotNewsChanelXMLParser new];
        [channelParser setParentParserDelegate:self];
        [parser setDelegate:channelParser];
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
//    [channelParser release];
}

@end
