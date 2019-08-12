//
//  FeedLentaDataSource.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIManagerProtocol.h"
#import "FeedRSSDataSourceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class FeedLentaDataSourceConfiguration;


@interface FeedLentaDataSource : NSObject<FeedRSSDataSourceProtocol>

@property (nonatomic, weak) id<FeedRSSDataSourceDelegate> delegate;
@property (nonatomic, strong) FeedLentaDataSourceConfiguration *configuration;

- (instancetype)initWithConfiguration:(FeedLentaDataSourceConfiguration *)aConfig;

@end


@interface FeedLentaDataSourceConfiguration : NSObject

@property (nonatomic, weak) id<APIManagerProtocol> apiManager;
@property (nonatomic, strong) id<XMLParserManagerProtocol> xmlParser;

@end

NS_ASSUME_NONNULL_END
