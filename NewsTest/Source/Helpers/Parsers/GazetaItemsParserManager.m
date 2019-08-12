//
//  GazetaItemsParserManager.m
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import "GazetaItemsParserManager.h"

#import "XMLReader.h"
#import "ItemModel.h"


static NSString *rssKey = @"rss";
static NSString *channelKey = @"channel";
static NSString *itemKey = @"item";

static NSString *titleKey = @"title";
static NSString *descriptionKey = @"description";
static NSString *linkKey = @"link";
static NSString *imageUrlKey = @"enclosure";
static NSString *publishDateKey = @"pubDate";

static NSString *textSubKey = @"text";
static NSString *urlSubKey = @"url";


@implementation GazetaItemsParserManager

#pragma mark - XMLParserManagerProtocol

- (NSArray<ItemModel *> *)getItemsFromXmlData:(NSData *)aData {
    NSMutableArray<ItemModel *> *resultArray = [NSMutableArray new];
    
    NSError *err;
    NSDictionary *rootDict = [XMLReader dictionaryForXMLData:aData error:&err];
    NSDictionary *itemsArray = rootDict[rssKey][channelKey][itemKey];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"EEE, d MMM yyyy HH:mm:ss ZZZ";
    
    for (NSDictionary *itemDict in itemsArray) {
        ItemModel *item = [ItemModel new];
        
        item.title = itemDict[titleKey][textSubKey];
        item.itemDescription = itemDict[descriptionKey][textSubKey];
        item.link = itemDict[linkKey][textSubKey];
        item.imageUrl = itemDict[imageUrlKey][urlSubKey]; 
        item.publishDate = [dateFormatter dateFromString: itemDict[publishDateKey][textSubKey]];
        item.source = ItemSourceTypeGazetaRu;
        
        [resultArray addObject:item];
    }
    
    return resultArray.copy;
}

@end
