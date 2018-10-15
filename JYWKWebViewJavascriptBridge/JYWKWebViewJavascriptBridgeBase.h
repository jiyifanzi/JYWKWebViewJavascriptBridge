//
//  JYWKWebViewJavascriptBridgeBase.h
//  FinderBox
//
//  Created by JiYi on 2018/10/11.
//  Copyright © 2018 JiYi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kOldProtocolScheme @"wvjbscheme"
#define kNewProtocolScheme @"https"
#define kQueueHasMessage   @"__wvjb_queue_message__"
#define kBridgeLoaded      @"__bridge_loaded__"

typedef void (^Callback)(id responseData);
typedef void (^Handler)(id data, Callback responseCallback);
typedef NSDictionary JYWVJBMessage;

typedef NSDictionary Message;


@protocol JYWKWebViewJavascriptBridgeBaseDelegate <NSObject>
- (NSString*) evaluateJavascript:(NSString*)javascript;
@end


@interface JYWKWebViewJavascriptBridgeBase : NSObject

@property (weak, nonatomic) id <JYWKWebViewJavascriptBridgeBaseDelegate> delegate;
@property (strong, nonatomic) NSMutableArray* startupMessageQueue;
@property (strong, nonatomic) NSMutableDictionary* responseCallbacks;
@property (strong, nonatomic) NSMutableDictionary* messageHandlers;
@property (strong, nonatomic) Handler messageHandler;

@property (nonatomic, assign) long uniqueId;


+ (void)enableLogging;
+ (void)setLogMaxLength:(int)length;
- (void)reset;
- (void)sendData:(id)data responseCallback:(Callback)responseCallback handlerName:(NSString*)handlerName;
- (void)flushMessageQueue:(NSString *)messageQueueString;
- (void)injectJavascriptFile;
- (BOOL)isWebViewJavascriptBridgeURL:(NSURL*)url;
- (BOOL)isQueueMessageURL:(NSURL*)urll;
- (BOOL)isBridgeLoadedURL:(NSURL*)urll;
- (void)logUnkownMessage:(NSURL*)url;
- (NSString *)webViewJavascriptCheckCommand;
- (NSString *)webViewJavascriptFetchQueyCommand;
- (void)disableJavscriptAlertBoxSafetyTimeout;

@end
