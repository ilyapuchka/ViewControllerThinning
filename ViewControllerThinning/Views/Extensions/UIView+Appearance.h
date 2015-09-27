 //
//  UIView+Appearance.h
//  ViewControllerThinning
//
//  Created by Ilya Puchka on 15.09.15.
//  Copyright © 2015 Ilya Puchka. All rights reserved.
//

@import UIKit;

@interface UIView (Appearance)

+ (instancetype)gh_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass;

@property (nonatomic) NSTimeInterval implicitAnimationDuration UI_APPEARANCE_SELECTOR;

@end
