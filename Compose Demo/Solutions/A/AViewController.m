//
//  AViewController.m
//  Compose Demo
//
//  Created on 2020-12-23.
//

#import "AViewController.h"
#import <WebKit/WebKit.h>

@interface AViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewTopSpaceLayoutConstraint;
@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"A" ofType:@"html"];
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    [self.webView loadHTMLString:content baseURL:nil];
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    self.webView.scrollView.delegate = self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.topViewTopSpaceLayoutConstraint.constant = -scrollView.contentOffset.y - self.webView.scrollView.contentInset.top;
}

@end
