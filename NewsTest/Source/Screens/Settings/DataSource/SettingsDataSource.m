//
//  SettingsDataSource.m
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import "SettingsDataSource.h"

@interface SettingsDataSource()

@property (nonatomic, strong) SettingsDataSourceConfig *configuration; 

@end


@implementation SettingsDataSource

- (void)updateWithConfig:(SettingsDataSourceConfig *)aConfig {
    self.configuration = aConfig;
}

#pragma mark - SettingsDataSourceProtocol

- (void)setFeedStyle:(NSInteger)aFeedStyle {
    [self.configuration.settingsManager setFeedType:aFeedStyle];
}

- (void)setRefreshInterval:(NSInteger)anInterval {
    [self.configuration.settingsManager setRefreshInterval:anInterval];
}

#pragma mark - SettingsViewDataSourceProtocol

- (NSInteger)getFeedStyle {
    return [self.configuration.settingsManager getFeedType];
}

- (NSInteger)getRefreshInterval {
    return [self.configuration.settingsManager getRefreshTimeInterval];
}

@end


@implementation SettingsDataSourceConfig
@end
