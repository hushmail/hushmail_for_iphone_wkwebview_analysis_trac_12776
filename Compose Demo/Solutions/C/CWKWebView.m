//
//  CWKWebView.m
//  Compose Demo
//
//  Created on 2020-12-22.
//

#import "CWKWebView.h"

@implementation CWKWebView

-(CGSize)intrinsicContentSize {
    NSLog(@"CWKWebView:tableView:intrinsicContentSize => scrollView.contentSize=(%f,%f)", self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    return self.scrollView.contentSize;
}

@end
