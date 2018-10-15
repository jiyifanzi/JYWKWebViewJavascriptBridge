//
//  JYWKWebViewJavascriptBridge.m
//  FinderBox
//
//  Created by JiYi on 2018/10/11.
//  Copyright © 2018 JiYi. All rights reserved.
//

#import "JYWKWebViewJavascriptBridge.h"
#import <WebKit/WebKit.h>
#import <WebKit/WKScriptMessageHandler.h>
#import "LeakAvoider.h"

static NSString *  iOS_Native_InjectJavascript = @"iOS_Native_InjectJavascript";
static NSString *  iOS_Native_FlushMessageQueue = @"iOS_Native_FlushMessageQueue";



@interface JYWKWebViewJavascriptBridge () <WKScriptMessageHandler, JYWKWebViewJavascriptBridgeBaseDelegate>

@end

@implementation JYWKWebViewJavascriptBridge  {
    WKWebView * _webView;
    JYWKWebViewJavascriptBridgeBase * _base;
    
}

- (instancetype)initWithWebView:(WKWebView *)webView{
    if (self == [super init]) {
        _webView = webView;
        _base = [[JYWKWebViewJavascriptBridgeBase alloc] init];
        _base.delegate = self;
        [self addScriptMessageHandlers];
    }
    return self;
}

- (void)dealloc {
    [self removeScriptMessageHandlers];
}

- (void)registerHandler:(NSString*)handlerName handler:(Handler)handler {
    _base.messageHandlers[handlerName] = handler;
}
- (void)removeHandler:(NSString*)handlerName {
    [_base.messageHandlers removeObjectForKey:handlerName];
}
- (void)callHandler:(NSString *)handlerName {
    
}
- (void)callHandler:(NSString *)handlerName data:(id)data responseCallback:(Callback)responseCallback {
    [_base sendData:data responseCallback:responseCallback handlerName:handlerName];
}

- (NSString *)evaluateJavascript:(NSString *)javascript {
    [_webView evaluateJavaScript:javascript completionHandler:^(id result, NSError * _Nullable error) {
        
    }];
    return  nil;
}

- (void)flushMessageQueue {
    [_webView evaluateJavaScript:@"WKWebViewJavascriptBridge._fetchQueue();" completionHandler:^(id result, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@",error);
        }
        
        [self->_base flushMessageQueue:result];
    }];

}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if (message.name == iOS_Native_FlushMessageQueue) {
        [self flushMessageQueue];
    }
    
    if (message.name == iOS_Native_InjectJavascript) {
        [_base injectJavascriptFile];
    }
    
}



- (void)addScriptMessageHandlers {
    __weak typeof(self) weakSelf = self;
    
    [_webView.configuration.userContentController addScriptMessageHandler:weakSelf name:iOS_Native_InjectJavascript];
    [_webView.configuration.userContentController addScriptMessageHandler:weakSelf name:iOS_Native_FlushMessageQueue];
}
- (void)removeScriptMessageHandlers {
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:iOS_Native_InjectJavascript];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:iOS_Native_FlushMessageQueue];
}



@end
