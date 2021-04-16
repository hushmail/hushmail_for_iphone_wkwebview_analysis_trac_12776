//
//  EViewController.m
//  Compose Demo
//
//  Created on 2020-12-23.
//

#import "EViewController.h"
#import <WebKit/WebKit.h>

@interface EViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIStackView *topStackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topStackViewTopSpaceLayoutConstraint;
@end

@implementation EViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"E" ofType:@"html"];
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    [self.webView loadHTMLString:content baseURL:nil];
    self.webView.scrollView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateWebViewContentInset];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.topStackViewTopSpaceLayoutConstraint.constant = -scrollView.contentOffset.y - self.webView.scrollView.contentInset.top;
}

- (IBAction)handleAddButton:(UIBarButtonItem *)sender {

    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor blueColor];
    [view addConstraint:[view.heightAnchor constraintEqualToConstant:100]];
    [self.topStackView addArrangedSubview:view];
    [self updateWebViewContentInset];
}

- (void)updateWebViewContentInset {

    CGSize size = [self.topStackView systemLayoutSizeFittingSize:self.view.frame.size withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityDefaultLow];
    
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(size.height, 0, 0, 0);
    
    [self.webView setNeedsLayout];
    
}

@end
