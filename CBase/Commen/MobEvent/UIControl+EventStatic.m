//
//  UIControl+JerryLiu.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 16/5/18.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

/*
 NSString *actionString = NSStringFromSelector(action);
 NSString *targetName = NSStringFromClass([target class]);
 NSDictionary *configDict = [self dictionaryFromUserStatisticsConfigPlist];
 eventID = configDict[targetName][@"ControlEventIDs"][actionString];
 */

#import "UIControl+EventStatic.h"

@implementation UIControl (JerryLiu)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzledSelector = @selector(swiz_sendAction:to:forEvent:);
        [HookUtility swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
    });
}

#pragma mark - Method Swizzling
- (void)swiz_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;
{
    [self performUserStastisticsAction:action to:target forEvent:event];
    [self swiz_sendAction:action to:target forEvent:event];
}

- (void)performUserStastisticsAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;
{
//    Print(@"\n***hook success:\n[1]action:%@\n[2]target:%@ \n[3]event:%ld", NSStringFromSelector(action), target, (long)event);
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ClassName"] = NSStringFromClass([self class]);
    if (self.superview != nil) {
        params[@"SuperViewClassName"] = NSStringFromClass([self.superview class]);
    }
    if (action != nil) {
        params[@"ControlAction"] = NSStringFromSelector(action);
    }
    if (target != nil) {
        params[@"ControlTarget"] = [NSString stringWithFormat:@"%@",target];
    }
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)self;
        if (button.titleLabel.text.length > 0) {
            params[@"ButtonTitle"] = button.titleLabel.text;
        }
    }
    [[BaiduMobStat defaultStat] logEvent:[NSString stringWithFormat:@"%ld",(long)event] eventLabel:NSStringFromSelector(action) attributes:params];
}
@end
