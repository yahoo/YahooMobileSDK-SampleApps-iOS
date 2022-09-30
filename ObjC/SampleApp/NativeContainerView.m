///
/// @file NativeContainerView.m
/// @brief Implementation of NativeContainerView.
///
/// @copyright Copyright Yahoo, Licensed under the terms of the Apache 2.0 license . See LICENSE file in project root for terms.
///

#import "NativeContainerView.h"
#import <YahooAds/YahooAds.h>

@interface NativeContainerView ()

@property (nonatomic) IBOutlet UIImageView *iconImageView;
@property (nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic) IBOutlet UIButton *ctaButton;
@property (nonatomic) IBOutlet UILabel *bodyLabel;
@property (nonatomic) IBOutlet UIImageView *mainImageView;
@property (nonatomic) IBOutlet UILabel *disclaimerLabel;

@end

@implementation NativeContainerView

- (void)setNativeAd:(YASNativeAd *)nativeAd
{
    _nativeAd = nativeAd;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)prepareView:(UIView *)view forComponent:(NSString *)componentId
{
    id<YASNativeViewComponent> component = (id<YASNativeViewComponent>)[self.nativeAd component:componentId];
    if ([component conformsToProtocol:@protocol(YASNativeTextComponent)]) {
        if ([view isKindOfClass:[UIButton class]]) {
            [(id<YASNativeTextComponent>)component prepareButton:(UIButton *)view];
        } else {
            [(id<YASNativeTextComponent>)component prepareLabel:(UILabel *)view];
        }
    } else if ([component conformsToProtocol:@protocol(YASNativeImageComponent)]) {
        [(id<YASNativeImageComponent>)component prepareView:(UIImageView *)view];
    }
}

- (void)updateView
{
    [self prepareView:self.iconImageView forComponent:@"iconImage"];
    [self prepareView:self.mainImageView forComponent:@"mainImage"];
    [self prepareView:self.titleLabel forComponent:@"title"];
    [self prepareView:self.bodyLabel forComponent:@"body"];
    [self prepareView:self.ctaButton forComponent:@"callToAction"];
    [self prepareView:self.disclaimerLabel forComponent:@"disclaimer"];
    
    [self.nativeAd registerContainerView:self];
}

- (void)anchorSubview:(UIView *)subview toSuperview:(UIView *)superview
{
    [subview setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *left = [NSLayoutConstraint
                                constraintWithItem:subview attribute:NSLayoutAttributeLeft
                                relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint
                                 constraintWithItem:subview attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                 NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint
                                 constraintWithItem:subview attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                 NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint
                                  constraintWithItem:subview attribute:NSLayoutAttributeBottom
                                  relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                  NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [NSLayoutConstraint activateConstraints:@[left, top, right, bottom]];
}

@end
