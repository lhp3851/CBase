//
//  UIView+MobEvent.m
//  StarZone
//
//  Created by 吕师 on 16/7/8.
//  Copyright © 2016年 xiangChaoKanKan. All rights reserved.
//

#import "UIView+EventStatic.h"
#import "HookUtility.h"

@implementation UIView (EventStatic)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        SEL originalSel = @selector(touchesBegan:withEvent:);
//        SEL swizzleSel = @selector(kk_touchesBegan:withEvent:);
//        [HookUtility swizzlingInClass:[self class]
//                     originalSelector:originalSel
//                     swizzledSelector:swizzleSel];
//    });
//}
//
//- (void)kk_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    Print(@"kk_touchesBegan:%@",NSStringFromClass([self class]));
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"ClassName"] = NSStringFromClass([self class]);
//    if (self.superview != nil) {
//        params[@"SuperViewClassName"] = NSStringFromClass([self.superview class]);
//    }
//    [MobClick event:@"UIViewTouch" attributes:params];
//    //此处不能调用该方法，会引起崩溃
////    [self kk_touchesBegan:touches withEvent:event];
//}

@end
