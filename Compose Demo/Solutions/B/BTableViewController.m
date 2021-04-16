//
//  BTableViewController.m
//  Compose Demo
//
//  Created on 2020-12-22.
//

#import "BTableViewController.h"
#import <WebKit/WebKit.h>

@interface BTableViewController () <WKScriptMessageHandler>
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (assign) CGFloat webViewContentHeight;
@end

@implementation BTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"B" ofType:@"html"];
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    self.webViewContentHeight = 500.0; // Experimenting with the starting height seems to affect whether or not you can scroll properly. Not sure what this means yet though.
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"My Script Message Handler"];
    [self.webView loadHTMLString:content baseURL:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        NSLog(@"tableView:heightForRowAtIndexPath:(section=%ld,row=%ld) => height=%f", (long)indexPath.section, (long)indexPath.row, self.webViewContentHeight);
        return self.webViewContentHeight;
    }
    return UITableViewAutomaticDimension;
}

- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    if ([message.name isEqualToString:@"My Script Message Handler"]) {
        self.webViewContentHeight = [message.body floatValue];
        NSLog(@"userContentController:didReceiveScriptMessage:(%f)", self.webViewContentHeight);
        [UIView performWithoutAnimation:^{
            [self.tableView layoutIfNeeded];
            [self.tableView beginUpdates];
            [self.tableView endUpdates];
        }];
    }
}

@end
