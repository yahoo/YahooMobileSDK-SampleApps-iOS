///
/// @file NativeContainerView.h
/// @brief Definition for NativeContainerView.
///
/// @copyright Copyright Yahoo, Licensed under the terms of the Apache 2.0 license . See LICENSE file in project root for terms.
///

#import <UIKit/UIKit.h>
#import <YahooAds/YASNativeAd.h>

@interface NativeContainerView : UIView

@property (nonatomic) YASNativeAd *nativeAd;

- (void)updateView;

@end
