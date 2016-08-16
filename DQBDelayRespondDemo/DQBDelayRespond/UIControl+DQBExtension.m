//
//  UIControl+DQBExtension.m
//  DQBDelayRespondDemo
//
//  Created by DQB on 8/16/16.
//  Copyright © 2016 DQB. All rights reserved.
//

#import "UIControl+DQBExtension.h"
#import <objc/runtime.h>

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIControl_ignoreEvent = "UIControl_ignoreEvent";

@interface UIControl ()
@property (nonatomic, assign) BOOL dqb_ignoreEvent;
@end

@implementation UIControl (DQBExtension)

- (NSTimeInterval)dqb_acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setDqb_acceptEventInterval:(NSTimeInterval)dqb_acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(dqb_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)dqb_ignoreEvent
{
    return [objc_getAssociatedObject(self, UIControl_ignoreEvent) boolValue];
}

- (void)setDqb_ignoreEvent:(BOOL)dqb_ignoreEvent
{
    objc_setAssociatedObject(self, UIControl_ignoreEvent, @(dqb_ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load
{
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(dqb_sendAction:to:forEvent:));
    method_exchangeImplementations(a, b);
}

- (void)dqb_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.dqb_ignoreEvent) {
        return;
    }
    if (self.dqb_acceptEventInterval > 0) {
        self.dqb_ignoreEvent = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.dqb_acceptEventInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.dqb_ignoreEvent = NO;
        });
    }
    [self dqb_sendAction:action to:target forEvent:event];
}

@end
