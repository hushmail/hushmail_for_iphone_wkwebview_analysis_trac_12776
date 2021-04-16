//
//  FViewController.m
//  Compose Demo
//
//  Created on 2020-12-23.
//

#import "FViewController.h"
#import <WebKit/WebKit.h>

@interface FViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackViewTopConstraint;
@end

@implementation FViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"F" ofType:@"html"];
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    [self.webView loadHTMLString:content baseURL:nil];
    self.webView.scrollView.delegate = self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrolled to %f", scrollView.contentOffset.y);
    self.stackViewTopConstraint.constant = -scrollView.contentOffset.y;
}

@end
