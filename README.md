InnerShadowView
==================

InnerShadowView is a view that allows you to quickly and easily add inner shadows to your views. It is configurable to allow shadows to grow from any or all of the view edges. The view is also IB Designable so you can create and modify the view from within Interface Builder, seeing your changes live.

## Usage

Use the InnerShadowView as you would any other UIView. See the property comments for more information.

## Animation

Due to the use of CAGradientLayers there are some additional steps needed to match any view frame animation. See the example below for an example of how this is accomplished

```objective-c
CGFloat duration = 0.5f;
self.shadowView.shadowAnimationDuration = duration;
self.shadowView.shadowAnimationTimingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

[UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    // Animate shadowView frame change here. 
} completion:^(BOOL finished) {

}];
```
