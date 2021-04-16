//
//  DWKWebView.m
//  Compose Demo
//
//  Created on 2020-12-22.
//

#import "DWKWebView.h"

@implementation DWKWebView

-(CGSize)intrinsicContentSize {
    NSLog(@"DWKWebView:tableView:intrinsicContentSize => scrollView.contentSize=(%f,%f)", self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    return self.scrollView.contentSize;
}

@end
