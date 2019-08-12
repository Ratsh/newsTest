//
//  SettingsViewController.h
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class SettingsViewControllerConfiguration;


@interface SettingsViewController : UIViewController<SettingsViewProtocol>

@property (nonatomic, strong, readonly) SettingsViewControllerConfiguration *configuration;

- (void)configureWith:(SettingsViewControllerConfiguration *)aConfig;

@end


@interface SettingsViewControllerConfiguration : NSObject

@property (nonatomic, strong) id<SettingsViewDelegate> presenter;
@property (nonatomic, weak) id<SettingsViewDataSourceProtocol> dataSource;

@end

NS_ASSUME_NONNULL_END
