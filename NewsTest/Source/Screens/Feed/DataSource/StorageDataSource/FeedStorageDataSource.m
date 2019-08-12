//
//  FeedStorageDataSource.m
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import "FeedStorageDataSource.h"

#import <CoreData/CoreData.h>
#import "ItemModel.h"
#import "AppDelegate.h"
#import "ItemEntity+CoreDataClass.h"


@interface FeedStorageDataSource()

@property (nonatomic, strong) NSArray<ItemModel *> *items;

@end


@implementation FeedStorageDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        [self updateItemsFromStorage];
    }
    return self;
}

- (void)updateItemsFromStorage {
    NSPersistentContainer *container = 
        ((AppDelegate *)[UIApplication sharedApplication].delegate).persistentContainer;
    NSManagedObjectContext *managedContext = container.viewContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ItemEntity"];
    NSArray *result = [managedContext executeFetchRequest:request error:nil];
    
    NSMutableArray *mutableItems = [NSMutableArray new];
    for (id entity in result) {
        ItemEntity *itemEntity = (ItemEntity *)entity;
        
        ItemModel *item = [ItemModel new];
        item.link = itemEntity.link;
        item.title = itemEntity.title;
        item.itemDescription = itemEntity.itemDescription;
        item.imageUrl = itemEntity.imageUrl;
        item.publishDate = itemEntity.publishDate;
        item.source = itemEntity.source;
        item.isRead = itemEntity.isRead;
        
        [mutableItems addObject:item];
    }
    
    self.items = mutableItems.copy;
}

#pragma mark - FeedStorageDataSourceProtocol

- (nonnull NSArray<ItemModel *> *)getItems { 
    return self.items.copy;
}

- (void)addItems:(NSArray<ItemModel *> *)anItems {
    NSPersistentContainer *container = 
        ((AppDelegate *)[UIApplication sharedApplication].delegate).persistentContainer;
    NSManagedObjectContext *managedContext = container.viewContext;
    
    for (ItemModel *item in anItems) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ItemEntity"];
        request.predicate = [NSPredicate predicateWithFormat:@"link == %@", item.link];
        NSArray *result = [managedContext executeFetchRequest:request error:nil];
        
        if (result.count > 0) {
            continue;
        }
        
        ItemEntity *itemEntity = [[ItemEntity alloc] initWithContext:managedContext];
        itemEntity.title = item.title;
        itemEntity.itemDescription = item.itemDescription;
        itemEntity.publishDate = item.publishDate;
        itemEntity.isRead = item.isRead;
        itemEntity.imageUrl = item.imageUrl;
        itemEntity.source = item.source;
        itemEntity.link = item.link;
        
        [managedContext save:nil];
    }
    
    [self updateItemsFromStorage];
}

- (void)setItemAsRead:(NSString *)anItemLink {
    NSPersistentContainer *container = 
        ((AppDelegate *)[UIApplication sharedApplication].delegate).persistentContainer;
    NSManagedObjectContext *managedContext = container.viewContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ItemEntity"];
    request.predicate = [NSPredicate predicateWithFormat:@"link == %@", anItemLink];
    NSArray *result = [managedContext executeFetchRequest:request error:nil];
    
    ItemEntity *itemEntity = result.firstObject;
    if (itemEntity) {
        itemEntity.isRead = YES;
        [managedContext save:nil];
    }

    for (ItemModel *item in self.items) {
        if ([item.link isEqualToString:anItemLink]) {
            item.isRead = YES;
            break;
        }
    }
}

@end
