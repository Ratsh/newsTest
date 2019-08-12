//
//  SettingsDataSource.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingsDataSourceProtocol.h"
#import "SettingsManagerProtocol.h"
#import "SettingsViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class SettingsDataSourceConfig;

@interface SettingsDataSource : NSObject<SettingsDataSourceProtocol, SettingsViewDataSourceProtocol>

@property (nonatomic, strong, readonly) SettingsDataSourceConfig *configuration;

- (void)updateWithConfig:(SettingsDataSourceConfig *)aConfig; 

@end


@interface SettingsDataSourceConfig : NSObject

@property (nonatomic, weak) id<SettingsDataSourceDelegate> delegate;
@property (nonatomic, weak) id<SettingsManagerProtocol> settingsManager;

@end

NS_ASSUME_NONNULL_END
