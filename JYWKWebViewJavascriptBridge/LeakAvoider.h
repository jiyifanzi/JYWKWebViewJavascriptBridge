//
//  LeakAvoider.h
//  FinderBox
//
//  Created by JiYi on 2018/10/11.
//  Copyright © 2018 JiYi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeakAvoider : NSObject

@property (nonatomic, weak) id delegate;

- (instancetype)initWithDelegate:(id)delegate;

@end
