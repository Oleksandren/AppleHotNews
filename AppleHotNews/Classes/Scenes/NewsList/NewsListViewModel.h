//
//  NewsListViewModel.h
//  AppleHotNews
//
//  Created by Oleksandr Nechet on 08.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSSChannel;
@class NetworkLayer;

typedef void (^ _Nonnull UpdatedChanelInfo)(RSSChannel *__nonnull chanel);
typedef void (^ _Nonnull ErrorOccured)(NSString *__nonnull errorMessage);


@protocol NewsListViewModelProtocol <NSObject>
@property (copy) UpdatedChanelInfo didUpdatedChanelInfo;
@property (copy) ErrorOccured didErrorOccured;
- (void)fetchEntries;
@end

@interface NewsListViewModel : NSObject <NewsListViewModelProtocol>
@property (nonatomic, unsafe_unretained) UIViewController * _Nonnull view;
@property (copy) UpdatedChanelInfo didUpdatedChanelInfo;
@property (copy) ErrorOccured didErrorOccured;

- (instancetype _Nonnull )initWithNetworkLayer:(NetworkLayer *_Nonnull)networkLayer;
- (void)fetchEntries;
@end
