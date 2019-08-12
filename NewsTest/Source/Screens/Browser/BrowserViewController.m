//
//  BrowserViewController.m
//  NewsTest
//
//  Created by ratsh on 8/11/19.
//  Copyright © 2019 ratsh. All rights reserved.
//

#import "BrowserViewController.h"

#import <WebKit/WebKit.h>

@interface BrowserViewController ()

@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) WKWebView *webView;

@end


@implementation BrowserViewController

- (instancetype)initWithUrlString:(NSString *)aUrlString {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _urlString = aUrlString;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:webView];
    self.webView = webView;
     
    [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlString]]]; 
}

@end
