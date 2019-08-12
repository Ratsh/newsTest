//
//  FeedPresenter.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedPresenterProtocol.h"
#import "FeedDataRepositoryProtocol.h"
#import "FeedViewProtocol.h"
#import "DependencyContainerProtocol.h"
#import "SettingsManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class FeedPresenterConfiguration;


@interface FeedPresenter : NSObject<FeedPresenterProtocol, FeedDataRepositoryDelegate, 
    FeedViewDelegate>

@property (nonatomic, strong, readonly) FeedPresenterConfiguration *configuration;

- (void)configureWithConfiguration:(FeedPresenterConfiguration *)aConfig;

@end


@interface FeedPresenterConfiguration : NSObject

@property (nonatomic, weak) id<FeedViewProtocol> view;
@property (nonatomic, strong) id<FeedDataRepositoryProtocol> repository;
@property (nonatomic, weak) id<DependencyContainerProtocol> dependencyContainer;
@property (nonatomic, weak) id<SettingsManagerProtocol> settingsManager;

@end

NS_ASSUME_NONNULL_END
