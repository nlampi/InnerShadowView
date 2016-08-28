//
//  InnerShadowView.m
//
//  Created by nlampi on 8/28/16.
//

#import "InnerShadowView.h"

@interface InnerShadowView ()

@property (nonatomic, strong) UIView *shadowLayerView;
@property (nonatomic, strong) CAGradientLayer *leftShadowLayer;
@property (nonatomic, strong) CAGradientLayer *rightShadowLayer;
@property (nonatomic, strong) CAGradientLayer *topShadowLayer;
@property (nonatomic, strong) CAGradientLayer *bottomShadowLayer;

@end


@implementation InnerShadowView


#pragma mark - Init

- (instancetype)init {
    self = [super init];
    
    if(self) {
        [self configureDefaults];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if(self) {
        [self configureDefaults];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
        [self configureDefaults];
    }
    
    return self;
}

- (void)configureDefaults {
    self.shadowAnimationDuration = 0;
    self.shadowAnimationTimingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    _shadowRadius = 3.0f;
    _fromColor = [UIColor blackColor];
    _toColor = [UIColor clearColor];
    self.leftInnerShadowEnabled = YES;
    self.rightInnerShadowEnabled = YES;
    self.topInnerShadowEnabled = YES;
    self.bottomInnerShadowEnabled = YES;
}


#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self updateInnerShadowFrames];
}


#pragma mark - Properties

- (void)setLeftInnerShadowEnabled:(BOOL)leftInnerShadowEnabled {
    _leftInnerShadowEnabled = leftInnerShadowEnabled;
    
    [self toggleLeftShadowLayerEnabled:leftInnerShadowEnabled];
}

- (void)setRightInnerShadowEnabled:(BOOL)rightInnerShadowEnabled {
    _rightInnerShadowEnabled = rightInnerShadowEnabled;
    
    [self toggleRightShadowLayerEnabled:rightInnerShadowEnabled];
}

- (void)setTopInnerShadowEnabled:(BOOL)topInnerShadowEnabled {
    _topInnerShadowEnabled = topInnerShadowEnabled;
    
    [self toggleTopShadowLayerEnabled:topInnerShadowEnabled];
}

- (void)setBottomInnerShadowEnabled:(BOOL)bottomInnerShadowEnabled {
    _bottomInnerShadowEnabled = bottomInnerShadowEnabled;
    
    [self toggleBottomShadowLayerEnabled:bottomInnerShadowEnabled];
}

- (void)setFromColor:(UIColor *)fromColor {
    _fromColor = fromColor;
    
    [self updateInnerShadowColors];
}

- (void)setToColor:(UIColor *)toColor {
    _toColor = toColor;
    
    [self updateInnerShadowColors];
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    _shadowRadius = shadowRadius;
    
    [self updateInnerShadowFrames];
}


#pragma mark - Inner Shadow Methods

- (void)updateInnerShadowFrames {
    [CATransaction begin];
    [CATransaction setAnimationTimingFunction:self.shadowAnimationTimingFunction];
    [CATransaction setAnimationDuration:self.shadowAnimationDuration];
    
    self.leftShadowLayer.frame = [self frameForLeftShadowLayer];
    self.rightShadowLayer.frame = [self frameForRightShadowLayer];
    self.topShadowLayer.frame = [self frameForTopShadowLayer];
    self.bottomShadowLayer.frame = [self frameForBottomShadowLayer];
    
    [CATransaction commit];
}

- (void)updateInnerShadowColors {
    NSArray *colorsArray = @[(id)self.fromColor.CGColor, (id)self.toColor.CGColor];
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:0];
    
    self.leftShadowLayer.colors = colorsArray;
    self.rightShadowLayer.colors = colorsArray;
    self.topShadowLayer.colors = colorsArray;
    self.bottomShadowLayer.colors = colorsArray;
    
    [CATransaction commit];
}

// Left Layer
- (void)toggleLeftShadowLayerEnabled:(BOOL)enabled {
    if(enabled && !self.leftShadowLayer) {
        CAGradientLayer *shadow = [CAGradientLayer layer];
        shadow.colors = @[(id)self.fromColor.CGColor, (id)self.toColor.CGColor];
        shadow.frame = [self frameForLeftShadowLayer];
        shadow.startPoint = CGPointMake(0.0, 0.5);
        shadow.endPoint = CGPointMake(1.0, 0.5);
        [self.layer insertSublayer:shadow atIndex:0];
        self.leftShadowLayer = shadow;
    } else if(!enabled) {
        [self.leftShadowLayer removeFromSuperlayer];
        self.leftShadowLayer = nil;
    }
}

- (CGRect)frameForLeftShadowLayer {
    
    return CGRectMake(0, 0, self.shadowRadius, self.bounds.size.height);
}

// Right Layer
- (void)toggleRightShadowLayerEnabled:(BOOL)enabled {
    if(enabled && !self.rightShadowLayer) {
        CAGradientLayer *shadow = [CAGradientLayer layer];
        shadow.colors = @[(id)self.fromColor.CGColor, (id)self.toColor.CGColor];
        shadow.frame = [self frameForRightShadowLayer];
        shadow.startPoint = CGPointMake(1.0, 0.5);
        shadow.endPoint = CGPointMake(0.0, 0.5);
        [self.layer insertSublayer:shadow atIndex:0];
        self.rightShadowLayer = shadow;
    } else if(!enabled) {
        [self.rightShadowLayer removeFromSuperlayer];
        self.rightShadowLayer = nil;
    }
}

- (CGRect)frameForRightShadowLayer {
    
    return CGRectMake(self.bounds.size.width - self.shadowRadius, 0, self.shadowRadius, self.bounds.size.height);
}

// Top Layer
- (void)toggleTopShadowLayerEnabled:(BOOL)enabled {
    if(enabled && !self.topShadowLayer) {
        CAGradientLayer *shadow = [CAGradientLayer layer];
        shadow.colors = @[(id)self.fromColor.CGColor, (id)self.toColor.CGColor];
        shadow.startPoint = CGPointMake(0.5, 0.0);
        shadow.endPoint = CGPointMake(0.5, 1.0);
        shadow.frame = [self frameForTopShadowLayer];
        [self.layer insertSublayer:shadow atIndex:0];
        self.topShadowLayer = shadow;
    } else if(!enabled) {
        [self.topShadowLayer removeFromSuperlayer];
        self.topShadowLayer = nil;
    }
}

- (CGRect)frameForTopShadowLayer {
    
    return CGRectMake(0, 0, self.bounds.size.width, self.shadowRadius);
}

// Bottom Layer
- (void)toggleBottomShadowLayerEnabled:(BOOL)enabled {
    if(enabled & !self.bottomShadowLayer) {
        CAGradientLayer *shadow = [CAGradientLayer layer];
        shadow.colors = @[(id)self.fromColor.CGColor, (id)self.toColor.CGColor];
        shadow.startPoint = CGPointMake(0.5, 1.0);
        shadow.endPoint = CGPointMake(0.5, 0.0);
        shadow.frame = [self frameForBottomShadowLayer];
        [self.layer insertSublayer:shadow atIndex:0];
        self.bottomShadowLayer = shadow;
    } else if(!enabled) {
        [self.bottomShadowLayer removeFromSuperlayer];
        self.bottomShadowLayer = nil;
    }
}

- (CGRect)frameForBottomShadowLayer {
    
    return CGRectMake(0, self.bounds.size.height - self.shadowRadius, self.bounds.size.width, self.shadowRadius);
}

@end
