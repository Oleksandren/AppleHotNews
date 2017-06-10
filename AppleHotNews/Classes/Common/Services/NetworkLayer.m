//
//  NSURLSessionNetworkLayer.m
//  AppleHotNews
//
//  Created by Oleksandr Nechet on 08.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

#import "NetworkLayer.h"

static NetworkLayer *shared = nil;

@interface NetworkLayer()
{
    NSMutableData *receivedData;
    NSURLConnection *connection;
}
@property (copy) CompletionHandler completionHandler;
@end

@implementation NetworkLayer

#pragma mark - Singleton Methods
+ (id)shared
{
    @synchronized(self) {
        if(shared == nil)
            shared = [[super allocWithZone:NULL] init];
    }
    return shared;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self shared] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}
- (NSUInteger)retainCount
{
    return UINT_MAX;
}

- (oneway void)release {}

- (id)autorelease
{
    return self;
}

- (id)init
{
    if (self = [super init]) {
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [connection release];
}

#pragma mark: - NetworkLayerProtocol
- (void)fetchDataByUrlString: (NSString *_Nonnull)urlString
                  completion:(CompletionHandler)completionHandler
{
    self.completionHandler = completionHandler;
    receivedData = [[NSMutableData alloc] init];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    connection = [[NSURLConnection alloc] initWithRequest:request
                                                 delegate:self
                                         startImmediately:YES];
    [url release];
    [request release];
}

#pragma mark - NSURLConnection Delegate

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
    self.completionHandler(receivedData, nil);
    [receivedData autorelease];
}

- (void)connection:(NSURLConnection *)conn
  didFailWithError:(NSError *)error {
    [receivedData release];
    
    self.completionHandler(nil, [error localizedDescription]);
}

@end
