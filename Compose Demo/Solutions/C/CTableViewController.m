//
//  CTableViewController.m
//  Compose Demo
//
//  Created on 2020-12-22.
//

#import "CTableViewController.h"
#import <WebKit/WebKit.h>

@interface CTableViewController () <WKScriptMessageHandler, WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@end

@implementation CTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"C" ofType:@"html"];
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    self.webView.navigationDelegate = self;
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"My Script Message Handler"];
    [self.webView loadHTMLString:content baseURL:nil];
}


- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    if ([message.name isEqualToString:@"My Script Message Handler"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"CTableViewController:userContentController:didReceiveScriptMessage:(%@)", message.body);
            [self.webView invalidateIntrinsicContentSize];
            [self.tableView beginUpdates];
            [self.tableView endUpdates];
        });
    }
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.readyState" completionHandler:^(id _Nullable complete, NSError * _Nullable error) {
        if (complete != nil) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"CTableViewController:webView:didFinishNavigation => webView.scrollView.contentSize=%f,%f", webView.scrollView.contentSize.width, webView.scrollView.contentSize.height);
                [webView invalidateIntrinsicContentSize];
                [self.tableView beginUpdates];
                [self.tableView endUpdates];
            });
        }
    }];
}

@end
