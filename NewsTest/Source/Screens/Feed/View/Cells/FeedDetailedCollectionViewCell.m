//
//  FeedDetailedCollectionViewCell.m
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import "FeedDetailedCollectionViewCell.h"

#import "UIImageView+AFNetworking.h"

@interface FeedDetailedCollectionViewCell()

@property (nonatomic, strong) FeedDetailedCollectionViewCellConfig *configuration;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *seenLabel;

@end


@implementation FeedDetailedCollectionViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self.imageView cancelImageDownloadTask];
    self.imageView.image = nil;
}

- (void)updateWithConfiguration:(FeedDetailedCollectionViewCellConfig *)aConfig {
    self.configuration = aConfig;
    
    self.sourceLabel.text = aConfig.source;
    self.titleLabel.text = aConfig.title;
    self.descriptionLabel.text = aConfig.descr;
    self.seenLabel.hidden = !aConfig.isSeen;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:aConfig.imageUrl]];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"d MMM HH:mm:ss";
    self.dateLabel.text = [dateFormatter stringFromDate:aConfig.publishDate]; 
}

@end


@implementation FeedDetailedCollectionViewCellConfig
@end
