///
/// @file NativeAccessorViewController.m
/// @brief Implementation of NativeAccessorViewController.
///
/// @copyright Copyright Yahoo, Licensed under the terms of the Apache 2.0 license . See LICENSE file in project root for terms.
///

#import "NativeAccessorViewController.h"
#import "NativeContainerView.h"
#import "AdPlacementConsts.h"
#import <YahooAds/YASUnifiedAdManager.h>

static const CGFloat kFadeInOutDuration = 0.3;

@interface NativeAccessorViewController()
@property (nonatomic, weak) IBOutlet UIButton *requestButton;
@property (nonatomic, weak) IBOutlet UIButton *showButton;
@property (nonatomic, weak) IBOutlet NativeContainerView *nativeAdContainer;
@end

@implementation NativeAccessorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showButton.enabled = NO;
    [self requestAd:self];
}

#pragma mark - User Interactiontory

- (IBAction)requestAd:(id)sender {
    self.requestButton.enabled = NO;
    self.showButton.enabled = NO;
    self.nativeAdContainer.alpha = 0.0;
    [self nativeAdDestroy];
    
    self.nativeAdContainer.nativeAd = [[YASNativeAd alloc] initWithPlacementId:kSampleAppNativeAdPlacementID];
    self.nativeAdContainer.nativeAd.delegate = self;
    [self.nativeAdContainer.nativeAd loadWithPlacementConfig:nil];
}

- (IBAction)showAd:(id)sender {
    self.showButton.enabled = NO;
    self.nativeAdContainer.alpha = 0.0;
    self.requestButton.enabled = YES;
    [UIView animateWithDuration:kFadeInOutDuration animations:^{
        self.nativeAdContainer.alpha = 1.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.nativeAdContainer updateView];
        }
    }];
}

- (void)nativeAdFailHandler:(YASErrorInfo *)errorInfo
{
    NSLog(@"Native ad load failed with error: %@", errorInfo);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.nativeAdContainer.nativeAd = nil;
        self.showButton.enabled = NO;
        self.requestButton.enabled = YES;
    });
}

- (void)nativeAdDestroy
{
    if (self.nativeAdContainer.nativeAd) {
        [self.nativeAdContainer.nativeAd destroy];
        self.nativeAdContainer.nativeAd = nil;
    }
}

#pragma mark - YASNativeAdDelegate

- (void)nativeAdDidLoad:(YASNativeAd *)nativeAd
{
    NSLog(@"Native ad did load");
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        strongSelf.nativeAdContainer.nativeAd = nativeAd;
        strongSelf.showButton.enabled = YES;
        strongSelf.requestButton.enabled = YES;
    });
}

- (void)nativeAdLoadDidFail:(YASNativeAd *)nativeAd withError:(YASErrorInfo *)errorInfo
{
    NSLog(@"Native ad load failed with error: %@", errorInfo);
    [self nativeAdFailHandler:errorInfo];
}

- (void)nativeAdDidFail:(YASNativeAd *)nativeAd withError:(YASErrorInfo *)errorInfo {
    NSLog(@"Native ad failed to display with error: %@", errorInfo);
    [self nativeAdFailHandler:errorInfo];
}

- (void)nativeAdDidClose:(YASNativeAd *)nativeAd
{
    NSLog(@"Native ad did close");
    [self nativeAdDestroy];
}

- (void)nativeAdClicked:(nonnull YASNativeAd *)nativeAd withComponent:(nonnull id<YASNativeComponent>)component
{
    NSLog(@"Native ad clicked.");
    [YahooAudiences logEventWithEventType:YahooAudiencesEventAdClick andParamBuilder:nil];
}

- (void)nativeAdDidLeaveApplication:(YASNativeAd *)nativeAd
{
    NSLog(@"Native ad caused user to leave application");
}

- (void)nativeAd:(YASNativeAd *)nativeAd event:(NSString *)eventId source:(NSString *)source arguments:(NSDictionary<NSString *, id> *)arguments
{
    NSLog(@"Native event occurred with ID: %@", eventId);
}

- (nullable UIViewController *)nativeAdPresentingViewController
{
    return self;
}

@end
