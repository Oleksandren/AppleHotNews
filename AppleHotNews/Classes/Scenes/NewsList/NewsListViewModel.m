//
//  NewsListViewModel.m
//  AppleHotNews
//
//  Created by Oleksandr Nechet on 08.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

#import "NewsListViewModel.h"
#import "NetworkLayer.h"
#import "XMLParser.h"

static NSString *const appleNewsUrlString = @"http://images.apple.com/main/rss/hotnews/hotnews.rss";

@interface NewsListViewModel ()
{
    NetworkLayer *_networkLayer;
}

@end

@implementation NewsListViewModel

- (instancetype)initWithNetworkLayer:(NetworkLayer *)networkLayer
{
    self = [super init];
    if (self) {
        _networkLayer = networkLayer;
    }
    
    return self;
}

- (void)fetchEntries
{
    [_networkLayer fetchDataByUrlString:appleNewsUrlString
                             completion:^(NSData * _Nullable receivedData, NSString * _Nullable errorMessage) {
                                 if (errorMessage) {
                                     self.didErrorOccured(errorMessage);
                                 }
                                 else {
                                     [[[XMLParser alloc] initWithData:receivedData
                                                           completion:^(RSSChannel *__nonnull chanel) {
                                                               self.didUpdatedChanelInfo(chanel);
                                                           }] autorelease];
                                 }
                             }];
}

@end
