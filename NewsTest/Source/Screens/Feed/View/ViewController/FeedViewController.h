//
//  FeedViewController.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class FeedViewControllerConfiguration;
@protocol SettingsManagerProtocol;


@interface FeedViewController : UIViewController <FeedViewProtocol>

@property (nonatomic, strong, readonly) FeedViewControllerConfiguration *configuration;

- (void)configureWithConfiguration:(FeedViewControllerConfiguration *)aConfig;

@end


@interface FeedViewControllerConfiguration : NSObject

@property (nonatomic, strong) id<FeedViewDelegate> presenter;
@property (nonatomic, weak) id<FeedViewDataSourceProtocol> dataSource;
@property (nonatomic, weak) id<SettingsManagerProtocol> settingsManager;

@end

NS_ASSUME_NONNULL_END
