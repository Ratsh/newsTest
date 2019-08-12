//
//  APIManager.m
//  NewsTest
//
//  Created by ratsh on 8/10/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import "APIManager.h"

#import <AFNetworking/AFNetworking.h>
#import "XMLParserManagerProtocol.h"

@interface APIManager()

@property (nonatomic, strong) AFURLSessionManager *sessionManager;

@end


@implementation APIManager

- (instancetype)init {
    self = [super init];
    
    if (self) {
        NSURLSessionConfiguration *configuration = 
            [NSURLSessionConfiguration defaultSessionConfiguration];
        self.sessionManager = 
            [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration]; 
    }
    
    return self;
}

#pragma mark - APIManagerProtocol

- (void)getRssDataFromUrlString:(NSString *)aUrlString 
                      xmlParser:(id<XMLParserManagerProtocol>)aParser
                 completion:(void(^)(NSArray<ItemModel *> *anItems, NSError *anError))aCompletion {
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer new];
    responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/rss+xml"];
    
    [self.sessionManager setResponseSerializer: responseSerializer];

    NSURL *URL = [NSURL URLWithString: aUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSessionDataTask *dataTask = [self.sessionManager dataTaskWithRequest:request 
                                                        completionHandler:^(NSURLResponse *response, 
                                                                            id responseObject, 
                                                                            NSError *error) {
        if (error) {
            if (aCompletion != nil) {
                aCompletion(nil, error);
            }
        } else {
            NSData *data = (NSData *)responseObject;
            NSArray *items = [aParser getItemsFromXmlData:data];
            if (aCompletion != nil) {
                aCompletion(items, nil);
            }
        }
    }];
    
    [dataTask resume];
}

@end
