//
//  FeedDataRepository.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedDataRepositoryProtocol.h"
#import "FeedViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class FeedDataRepositoryConfiguration;
@protocol FeedStorageDataSourceProtocol, FeedRSSDataSourceProtocol, FeedViewDataSourceProtocol;


@interface FeedDataRepository : NSObject<FeedDataRepositoryProtocol, FeedViewDataSourceProtocol>

@property (nonatomic, weak) id<FeedDataRepositoryDelegate> delegate;
@property (nonatomic, strong, readonly) FeedDataRepositoryConfiguration *configuration;

- (instancetype)initWithConfiguration:(FeedDataRepositoryConfiguration *)aConfig;

@end


@interface FeedDataRepositoryConfiguration : NSObject

@property (nonatomic, strong) id<FeedStorageDataSourceProtocol> storageDataSource;
@property (nonatomic, strong) NSArray<id<FeedRSSDataSourceProtocol>> *rssDataSources;

@end

NS_ASSUME_NONNULL_END
