//
//  FeedViewController.m
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import "FeedViewController.h"

#import "FeedDetailedCollectionViewCell.h"
#import "FeedSimpleCollectionCell.h"
#import "ItemModel.h"
#import "SettingsManagerProtocol.h"


static NSString *simpleCellIdentifier = @"simpleCellIdentifier";
static NSString *detailedCellIdentifier = @"detailedCellIdentifier";


@interface FeedViewController() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) FeedViewControllerConfiguration *configuration;
@property (nonatomic, strong) UICollectionView *collectionView;

@end


@implementation FeedViewController

- (void)configureWithConfiguration:(FeedViewControllerConfiguration *)aConfig {
    self.configuration = aConfig;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self setupCollectionView];
    [self setupNavBar];
    
    [self.configuration.presenter viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.configuration.presenter viewWillAppear];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
//workaround orientation layout
    [self.collectionView reloadData];
//
}

#pragma mark - Private

+ (NSString *)sourceStringFromSource:(ItemSourceType)aSourceType {
    NSString *sourceString = @"";
    switch (aSourceType) {
        case ItemSourceTypeLentaRu:
            sourceString = @"Lenta.ru";
            break;
        case ItemSourceTypeGazetaRu:
            sourceString = @"Gazeta.ru";
            break;
    }
    return sourceString;
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumLineSpacing = 0.0;
    flowLayout.minimumInteritemSpacing = 0.0;
    
    UICollectionView *collection = 
        [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collection.backgroundColor = [UIColor whiteColor];
    collection.autoresizingMask = 
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collection.delegate = self;
    collection.dataSource = self;
    
    UINib *simpleCellNib = [UINib nibWithNibName:@"FeedSimpleCollectionCell" bundle:nil]; 
    [collection registerNib:simpleCellNib forCellWithReuseIdentifier:simpleCellIdentifier];
    UINib *detailedCellNib = [UINib nibWithNibName:@"FeedDetailedCollectionViewCell" bundle:nil]; 
    [collection registerNib:detailedCellNib forCellWithReuseIdentifier:detailedCellIdentifier];
    
    [self.view addSubview:collection];
    self.collectionView = collection;
}

- (UICollectionViewCell *)getSimpleCellForIndexPath:(NSIndexPath *)anIndexPath {
    NSString *cellIdentifier = simpleCellIdentifier;
    
    ItemModel *item = [self.configuration.dataSource getItemAtIndex:anIndexPath.item];
                  
    UICollectionViewCell *cell = 
        [self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier 
                                                       forIndexPath:anIndexPath];
                                                       
    if ([cell isKindOfClass:[FeedSimpleCollectionCell class]]) {
        FeedSimpleCollectionCellConfig *config = [FeedSimpleCollectionCellConfig new];
        config.title = item.title;
        config.imageUrl = item.imageUrl;
        config.isSeen = item.isRead;
        config.source = [[self class] sourceStringFromSource:item.source];
        
        [(FeedSimpleCollectionCell *)cell updateWithConfiguration:config]; 
    }
                                     
    return cell;
}

- (UICollectionViewCell *)getDetailedCellForIndexPath:(NSIndexPath *)anIndexPath {
    NSString *cellIdentifier = detailedCellIdentifier;
    
    ItemModel *item = [self.configuration.dataSource getItemAtIndex:anIndexPath.item];
                  
    UICollectionViewCell *cell = 
        [self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier 
                                                       forIndexPath:anIndexPath];
                                                       
    if ([cell isKindOfClass:[FeedDetailedCollectionViewCell class]]) {
        FeedDetailedCollectionViewCellConfig *config = [FeedDetailedCollectionViewCellConfig new];
        config.title = item.title;
        config.descr = item.itemDescription;
        config.imageUrl = item.imageUrl;
        config.isSeen = item.isRead;
        config.source = [[self class] sourceStringFromSource:item.source];
        config.publishDate = item.publishDate;
        
        [(FeedDetailedCollectionViewCell *)cell updateWithConfiguration:config]; 
    }
                                     
    return cell;
}

- (void)setupNavBar {
    UIButton *button = [UIButton new];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"Settings" forState:UIControlStateNormal];
    [button addTarget:self 
               action:@selector(settingsPressed:) 
     forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)settingsPressed:(id)aSender {
    [self.configuration.presenter settingsPressed];
}

#pragma mark - FeedViewProtocol

- (void)refresh {
    [self.collectionView reloadData];
}

- (void)pushViewController:(UIViewController *)aController {
    [self.navigationController pushViewController:aController animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView 
     numberOfItemsInSection:(NSInteger)section {
     
    return [self.configuration.dataSource getItems].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView 
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch ([self.configuration.settingsManager getFeedType]) {
        case FeedTypeSimple:
            return [self getSimpleCellForIndexPath:indexPath];

        case FeedTypeDetailed:
            return [self getDetailedCellForIndexPath:indexPath];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView 
                  layout:(UICollectionViewLayout*)collectionViewLayout 
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat height = 70.0;
    switch ([self.configuration.settingsManager getFeedType]) {
        case FeedTypeDetailed:
            height = 200.0;
            break;
        default:
            break;
    }

    return CGSizeMake([UIScreen mainScreen].bounds.size.width, height);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView 
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    ItemModel *item = [self.configuration.dataSource getItemAtIndex:indexPath.item];
    if (item) {
        [self.configuration.presenter didSelectItem:item];
    }
}

@end


@implementation FeedViewControllerConfiguration
@end
