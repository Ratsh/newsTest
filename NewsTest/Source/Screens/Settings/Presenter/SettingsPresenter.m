//
//  SettingsPresenter.m
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import "SettingsPresenter.h"

@interface SettingsPresenter()

@property (nonatomic, strong) SettingsPresenterConfiguration *configuration;

@end


@implementation SettingsPresenter

- (void)configureWith:(SettingsPresenterConfiguration *)aConfig {
    self.configuration = aConfig;
}

#pragma mark - SettingsViewDelegate

- (void)feedStyleChangedTo:(NSInteger)aNewStyle {
    [self.configuration.dataSource setFeedStyle:aNewStyle];
    [self.configuration.view update];
}

- (void)refreshIntervalChangedTo:(NSInteger)aNewInterval {
    [self.configuration.dataSource setRefreshInterval:aNewInterval];
    [self.configuration.view update];
}

#pragma mark - SettingsDataSourceDelegate

@end


@implementation SettingsPresenterConfiguration
@end
