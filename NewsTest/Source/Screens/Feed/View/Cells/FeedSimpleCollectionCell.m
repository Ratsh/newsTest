//
//  FeedSimpleCollectionCell.m
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import "FeedSimpleCollectionCell.h"

#import "UIImageView+AFNetworking.h"

@interface FeedSimpleCollectionCell()

@property (nonatomic, strong) FeedSimpleCollectionCellConfig *configuration;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *seenLabel;

@end


@implementation FeedSimpleCollectionCell

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self.imageView cancelImageDownloadTask];
    self.imageView.image = nil;
}

- (void)updateWithConfiguration:(FeedSimpleCollectionCellConfig *)aConfig {
    self.configuration = aConfig;
    
    self.sourceLabel.text = aConfig.source;
    self.titleLabel.text = aConfig.title;
    self.seenLabel.hidden = !aConfig.isSeen;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:aConfig.imageUrl]]; 
}

@end


@implementation FeedSimpleCollectionCellConfig
@end
