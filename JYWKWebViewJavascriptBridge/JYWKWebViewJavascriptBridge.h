//
//  JYWKWebViewJavascriptBridge.h
//  FinderBox
//
//  Created by JiYi on 2018/10/11.
//  Copyright © 2018 JiYi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYWKWebViewJavascriptBridgeBase.h"
#import <WebKit/WebKit.h>
#import "JYWKWebViewJavascriptBridgeJS.h"

@interface JYWKWebViewJavascriptBridge : JYWKWebViewJavascriptBridgeBase

- (instancetype)initWithWebView:(WKWebView *)webView;

- (void)registerHandler:(NSString*)handlerName handler:(Handler)handler;
- (void)removeHandler:(NSString*)handlerName;
- (void)callHandler:(NSString*)handlerName data:(id)data responseCallback:(Callback)responseCallback;

@end
