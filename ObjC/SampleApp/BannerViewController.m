///
/// @file BannerViewController.m
/// @brief Implementation for BannerViewController
///
/// @copyright Copyright Yahoo, Licensed under the terms of the Apache 2.0 license . See LICENSE file in project root for terms.
///

#import "BannerViewController.h"
#import "AdPlacementConsts.h"
#import <YahooAds/YahooAds.h>

static const CGFloat kFadeInOutDuration = 0.3;

@interface BannerViewController () <YASInlineAdViewDelegate>
@property (nonatomic, strong) IBOutlet UIButton *requestButton;
@property (nonatomic) IBOutlet UIActivityIndicatorView *spinnerView;
@property (weak, nonatomic) IBOutlet UIView *inlineBannerView;
@property (nonatomic, strong) YASInlineAdView *inlineAd;
@end

@implementation BannerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Inline Banner";
    [self requestInline:nil];
}

- (IBAction)requestInline:(id)sender
{
    [self destroyAd];
    [self uiFetchInProgress:YES];
    self.inlineBannerView.alpha = 0.0;
    
    self.inlineAd = [[YASInlineAdView alloc] initWithPlacementId:kSampleAppBannerAdPlacementID];
    self.inlineAd.delegate = self;
    [self.inlineAd loadWithPlacementConfig:nil];
}

- (void)showAd
{
    self.inlineBannerView.alpha = 0.0;
    self.inlineAd.frame = self.inlineBannerView.bounds;
    [self.inlineBannerView addSubview:self.inlineAd];
    
    [UIView animateWithDuration:kFadeInOutDuration animations:^{
        self.inlineBannerView.alpha = 1.0;
    } completion: nil];
}

- (void)destroyAd
{
    [self.inlineAd removeFromSuperview];
    self.inlineAd = nil;
}

- (void)uiFetchInProgress:(BOOL)inProgress
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(self) strongSelf = weakSelf;
        if (inProgress) {
            [strongSelf.spinnerView startAnimating];
        }
        else {
            [strongSelf.spinnerView stopAnimating];
        }
        strongSelf.requestButton.enabled = ! inProgress;
    });
}

#pragma mark - YASInlineAdViewDelegate

- (void)inlineAdDidLoad:(YASInlineAdView *)inlineAd
{
    NSLog(@"Inline ad did load");
    [self uiFetchInProgress:NO];
    self.inlineAd = inlineAd;
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        [strongSelf showAd];
    });
}

- (void)inlineAdLoadDidFail:(YASInlineAdView *)inlineAd withError:(YASErrorInfo *)errorInfo
{
    [self uiFetchInProgress:NO];
    NSLog(@"Inline ad load did fail with error: %@", errorInfo);
}

- (void)inlineAdDidFail:(YASInlineAdView *)inlineAd withError:(YASErrorInfo *)errorInfo
{
    NSLog(@"Inline ad failed to display with error: %@", errorInfo);
}

- (void)inlineAdDidExpand:(YASInlineAdView *)inlineAd
{
    NSLog(@"Inline ad expanded");
}

- (void)inlineAdDidCollapse:(YASInlineAdView *)inlineAd
{
    NSLog(@"Inline ad collapsed");
}

- (void)inlineAdClicked:(YASInlineAdView *)inlineAd
{
    NSLog(@"Inline ad clicked");
    [YahooAudiences logEventWithEventType:YahooAudiencesEventAdClick andParamBuilder:nil];
}

- (void)inlineAdDidLeaveApplication:(YASInlineAdView *)inlineAd
{
    NSLog(@"Inline ad did cause user to leave application");
}

- (void)inlineAdDidResize:(YASInlineAdView *)inlineAd
{
    NSLog(@"Inline ad did resize");
}

- (void)inlineAdDidRefresh:(YASInlineAdView *)inlineAd
{
    NSLog(@"Inline ad did refresh");
}

- (nullable UIViewController *)inlineAdPresentingViewController
{
    return self;
}

- (void)inlineAd:(nonnull YASInlineAdView *)inlineAd event:(nonnull NSString *)eventId source:(nonnull NSString *)source arguments:(nonnull NSDictionary<NSString *,id> *)arguments
{
     NSLog(@"Inline ad event occurred with ID: %@", eventId);
}

@end
