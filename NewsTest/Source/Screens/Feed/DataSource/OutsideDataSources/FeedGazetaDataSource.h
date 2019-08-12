//
//  FeedGazetaDataSource.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIManagerProtocol.h"
#import "FeedRSSDataSourceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class FeedGazetaDataSourceConfiguration;


@interface FeedGazetaDataSource : NSObject<FeedRSSDataSourceProtocol>

@property (nonatomic, weak) id<FeedRSSDataSourceDelegate> delegate;
@property (nonatomic, strong) FeedGazetaDataSourceConfiguration *configuration;

- (instancetype)initWithConfiguration:(FeedGazetaDataSourceConfiguration *)aConfig;

@end


@interface FeedGazetaDataSourceConfiguration : NSObject

@property (nonatomic, weak) id<APIManagerProtocol> apiManager;
@property (nonatomic, strong) id<XMLParserManagerProtocol> xmlParser;

@end

NS_ASSUME_NONNULL_END
