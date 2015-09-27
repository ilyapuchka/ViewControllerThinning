//
//  UIView+Appearance.m
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 15.09.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

#import "UIView+Appearance.h"

@import ObjectiveC.runtime;

@implementation UIView (Appearance)

+ (instancetype)gh_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [self appearanceWhenContainedIn:containerClass, nil];
}

- (void)setImplicitAnimationDuration:(NSTimeInterval)implicitAnimationDuration
{
    objc_setAssociatedObject(self, @selector(implicitAnimationDuration), @(implicitAnimationDuration), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)implicitAnimationDuration
{
    return [objc_getAssociatedObject(self, @selector(implicitAnimationDuration)) ?: @(0.25) doubleValue];
}

@end

