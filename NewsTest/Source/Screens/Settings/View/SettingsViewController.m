//
//  SettingsViewController.m
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import "SettingsViewController.h"


@interface SettingsViewController ()

@property (nonatomic, strong) SettingsViewControllerConfiguration *configuration;

@property (weak, nonatomic) IBOutlet UILabel *refreshTimeLabel;
@property (weak, nonatomic) IBOutlet UISlider *refreshIntervalSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *feedStyleSegControl;

@end


@implementation SettingsViewController

- (void)configureWith:(SettingsViewControllerConfiguration *)aConfig {
    self.configuration = aConfig;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self update];
}

#pragma mark - Private

- (IBAction)feedStyleChanged:(UISegmentedControl *)sender {
    [self.configuration.presenter feedStyleChangedTo:sender.selectedSegmentIndex];
}

- (IBAction)refreshIntervalChanged:(UISlider *)sender {
    NSInteger newValue = (NSInteger)round(sender.value);
    [self.refreshIntervalSlider setValue:newValue animated:YES];
    [self updateRefreshIntervalLabelText:newValue];
    [self.configuration.presenter refreshIntervalChangedTo:newValue];
}

- (void)updateRefreshIntervalLabelText:(NSInteger)aValue {
    self.refreshTimeLabel.text = [NSString stringWithFormat:@"%ld min", aValue];
}

#pragma mark - SettingsViewProtocol

- (void)update {
    NSInteger feedStyle = [self.configuration.dataSource getFeedStyle];
    NSInteger refreshInterval = [self.configuration.dataSource getRefreshInterval];
    
    self.feedStyleSegControl.selectedSegmentIndex = feedStyle;
    self.refreshIntervalSlider.value = refreshInterval;
    [self updateRefreshIntervalLabelText:refreshInterval];
}

@end


@implementation SettingsViewControllerConfiguration
@end
