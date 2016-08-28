//
//  InnerShadowView.h
//
//  Created by nlampi on 8/28/16.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface InnerShadowView : UIView

/**
 * Toggle these properties to enable or disable inner shadows from the specified edge
 * By default all edges are enabled
 */
@property (nonatomic, readwrite) IBInspectable BOOL leftInnerShadowEnabled;
@property (nonatomic, readwrite) IBInspectable BOOL rightInnerShadowEnabled;
@property (nonatomic, readwrite) IBInspectable BOOL topInnerShadowEnabled;
@property (nonatomic, readwrite) IBInspectable BOOL bottomInnerShadowEnabled;

/// Shadow Radius is the width of the inner shadow
@property (nonatomic, readwrite) IBInspectable CGFloat shadowRadius;

/// From Color is the outer edge color, defaults to Black
@property (nonatomic, strong) IBInspectable UIColor *fromColor;

/// To color is the inner color, defaults to Clear
@property (nonatomic, strong) IBInspectable UIColor *toColor;

/**
 * Shadow animation duration and timing functions are needed when animating a change
 * of the view's frame. This is to align the UIView and CALayer animations.
 * The default behavior is to have no animation.
 */
@property (nonatomic, readwrite) CGFloat shadowAnimationDuration; /// Duration of the animation
@property (nonatomic, strong) CAMediaTimingFunction *shadowAnimationTimingFunction; /// Timing function should match what is used for the UIView animation.

@end
