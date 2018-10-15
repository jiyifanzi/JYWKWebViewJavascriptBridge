//
//  LeakAvoider.m
//  FinderBox
//
//  Created by JiYi on 2018/10/11.
//  Copyright © 2018 JiYi. All rights reserved.
//

#import "LeakAvoider.h"
#import <WebKit/WebKit.h>

@interface LeakAvoider ()<WKScriptMessageHandler>

@end

@implementation LeakAvoider

- (instancetype)initWithDelegate:(id)delegate {
    if (self == [super init]) {
        self.delegate = delegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [self.delegate userContentController:userContentController didReceiveScriptMessage:message];
}



@end
