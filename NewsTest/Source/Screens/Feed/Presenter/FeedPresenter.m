//
//  FeedPresenter.m
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import "FeedPresenter.h"

#import "ItemModel.h"


@interface FeedPresenter()

@property (nonatomic, strong) FeedPresenterConfiguration *configuration;
@property (nonatomic, strong) NSTimer *refreshTimer;
@property (nonatomic, assign) NSInteger refreshTimerInterval;

@end


@implementation FeedPresenter

- (void)configureWithConfiguration:(FeedPresenterConfiguration *)aConfig {
    self.configuration = aConfig;
}

#pragma mark - Private

- (void)updateTimerIfNeeded {
    NSInteger currentInterval = [self.configuration.settingsManager getRefreshTimeInterval];
    if (self.refreshTimer && currentInterval == self.refreshTimerInterval) {
        return;
    }
    
    [self.refreshTimer invalidate];
    
    [self onTimerFired];
    self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:currentInterval * 60 
                                                         target:self 
                                                       selector:@selector(onTimerFired)
                                                       userInfo:nil 
                                                        repeats:YES];
    self.refreshTimerInterval = currentInterval;
}

- (void)onTimerFired {
    [self.configuration.repository reload];
}

#pragma mark - FeedPresenterProtocol

#pragma mark - FeedDataRepositoryDelegate

- (void)repositoryDidUpdateData:(nonnull id<FeedDataRepositoryProtocol>)aRepository { 
    [self.configuration.view refresh];
}

- (void)repository:(nonnull id<FeedDataRepositoryProtocol>)aRepository 
    didFinishWithError:(nonnull NSError *)anError {
#warning TODO: handle error     
}

#pragma mark - FeedViewDelegate

- (void)viewDidLoad {
    [self.configuration.repository reload];
    [self.configuration.view refresh];
    [self updateTimerIfNeeded];
}

- (void)viewWillAppear {
    [self.configuration.view refresh];
    [self updateTimerIfNeeded];
}

- (void)didSelectItem:(ItemModel *)anItem {
    UIViewController *browserViewController = 
        [self.configuration.dependencyContainer createBrowserModuleWithUrl:anItem.link];
    [self.configuration.view pushViewController:browserViewController];
    
    [self.configuration.repository setItemAsRead:anItem.link];
}

- (void)settingsPressed {
    UIViewController *settingsViewController = 
        [self.configuration.dependencyContainer createSettingsModule];
    [self.configuration.view pushViewController:settingsViewController];
}

@end


@implementation FeedPresenterConfiguration
@end
