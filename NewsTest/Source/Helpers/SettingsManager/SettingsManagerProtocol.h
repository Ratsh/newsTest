//
//  SettingsManagerProtocol.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FeedType) {
   FeedTypeSimple = 0,
   FeedTypeDetailed,
};

@protocol SettingsManagerProtocol<NSObject>

- (FeedType)getFeedType;
- (void)setFeedType:(FeedType)aNewType;

- (NSInteger)getRefreshTimeInterval;
- (void)setRefreshInterval:(NSInteger)anInterval;

@end

NS_ASSUME_NONNULL_END
