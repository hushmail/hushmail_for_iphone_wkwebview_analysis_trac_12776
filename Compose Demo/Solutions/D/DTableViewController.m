//
//  DTableViewController.m
//  Compose Demo
//
//  Created on 2020-12-22.
//

#import "DTableViewController.h"
#import <WebKit/WebKit.h>

@interface DTableViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (assign) CGSize latestWebViewContentSize;
@end

@implementation DTableViewController

static int kObservingContentSizeChangesContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:0 context:&kObservingContentSizeChangesContext];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"D" ofType:@"html"];
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    [self.webView loadHTMLString:content baseURL:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == &kObservingContentSizeChangesContext) {
        UIScrollView *scrollView = object;
        if (!CGSizeEqualToSize(scrollView.contentSize, self.latestWebViewContentSize)) {
            [self.webView invalidateIntrinsicContentSize];
            [self.tableView beginUpdates];
            [self.tableView endUpdates];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
