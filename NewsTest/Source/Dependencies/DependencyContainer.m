//
//  DependencyContainer.m
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import "DependencyContainer.h"

#import "APIManager.h"
#import "SettingsManager.h"

#import "FeedStorageDataSource.h"
#import "LentaItemsParserManager.h"
#import "GazetaItemsParserManager.h"
#import "FeedDataRepository.h"
#import "FeedLentaDataSource.h"
#import "FeedGazetaDataSource.h"
#import "FeedPresenter.h"
#import "FeedViewController.h"

#import "BrowserViewController.h"

#import "SettingsViewController.h"
#import "SettingsDataSource.h"
#import "SettingsPresenter.h"


@interface DependencyContainer()

@property (nonatomic, strong) APIManager *apiManager;
@property (nonatomic, strong) SettingsManager *settingsManager;

@end


@implementation DependencyContainer

- (instancetype)init {
    self = [super init];
    if (self) {
#warning TODO: move this managers to another place, i.e. Application class. Leave here only module constructors.    
        self.apiManager = [APIManager new];
        self.settingsManager = [SettingsManager new];
//
    }
    return self;
}

#pragma mark - DependencyContainerProtocol

- (UIViewController<FeedViewProtocol> *)createFeedModule {
    FeedLentaDataSourceConfiguration *lentaConfig = [FeedLentaDataSourceConfiguration new];
    lentaConfig.apiManager = self.apiManager;
    lentaConfig.xmlParser = [LentaItemsParserManager new];
    FeedLentaDataSource *lentaDataSource = 
        [[FeedLentaDataSource alloc] initWithConfiguration:lentaConfig];
    
    FeedGazetaDataSourceConfiguration *gazetaConfig = [FeedGazetaDataSourceConfiguration new];
    gazetaConfig.apiManager = self.apiManager;
    gazetaConfig.xmlParser = [GazetaItemsParserManager new];
    FeedGazetaDataSource *gazetaDataSource = 
        [[FeedGazetaDataSource alloc] initWithConfiguration:gazetaConfig];
        
    FeedStorageDataSource *storageDataSource = [FeedStorageDataSource new];
        
    FeedDataRepositoryConfiguration *repositoryConfig = [FeedDataRepositoryConfiguration new];
    repositoryConfig.storageDataSource = storageDataSource;
    repositoryConfig.rssDataSources = @[lentaDataSource, gazetaDataSource];
    FeedDataRepository *repository = 
        [[FeedDataRepository alloc] initWithConfiguration:repositoryConfig];
        
    FeedPresenter *presenter = [FeedPresenter new];
    FeedViewController *viewController = 
        [[FeedViewController alloc] initWithNibName:@"FeedViewController" bundle:nil];
        
    repository.delegate = presenter;
    
    FeedPresenterConfiguration *presenterConfig = [FeedPresenterConfiguration new];
    presenterConfig.view = viewController;
    presenterConfig.repository = repository;
    presenterConfig.dependencyContainer = self;
    presenterConfig.settingsManager = self.settingsManager;
    [presenter configureWithConfiguration:presenterConfig];
    
    FeedViewControllerConfiguration *viewConfig = [FeedViewControllerConfiguration new];
    viewConfig.presenter = presenter;
    viewConfig.dataSource = repository;
    viewConfig.settingsManager = self.settingsManager;
    [viewController configureWithConfiguration:viewConfig]; 
    
    return viewController;
}

- (UIViewController<BrowserProtocol> *)createBrowserModuleWithUrl:(NSString *)aUrl {
    return [[BrowserViewController alloc] initWithUrlString:aUrl];
}

- (UIViewController<SettingsViewProtocol> *)createSettingsModule {
    SettingsPresenter *presenter = [SettingsPresenter new];
    SettingsDataSource *dataSource = [SettingsDataSource new];
    SettingsViewController *viewController = 
        [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
        
    SettingsPresenterConfiguration *presenterConfig = [SettingsPresenterConfiguration new];
    presenterConfig.view = viewController;
    presenterConfig.dataSource = dataSource;
    [presenter configureWith:presenterConfig];
    
    SettingsViewControllerConfiguration *viewConfig = [SettingsViewControllerConfiguration new];
    viewConfig.presenter = presenter;
    viewConfig.dataSource = dataSource;
    [viewController configureWith:viewConfig];
    
    SettingsDataSourceConfig *dataSourceConfig = [SettingsDataSourceConfig new];
    dataSourceConfig.delegate = presenter;
    dataSourceConfig.settingsManager = self.settingsManager;
    [dataSource updateWithConfig:dataSourceConfig];
    
    return viewController;
}

@end
