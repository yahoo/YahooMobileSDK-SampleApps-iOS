///
/// @file RectangleViewController.m
/// @brief Implementation for RectangleViewController
///
/// @copyright Copyright Yahoo, Licensed under the terms of the Apache 2.0 license . See LICENSE file in project root for terms.
///

#import "RectangleViewController.h"
#import "AdPlacementConsts.h"
#import <YahooAds/YahooAds.h>

static const CGFloat kFadeInOutDuration = 0.3;

@interface RectangleViewController () <YASInlineAdViewDelegate>
@property (nonatomic, strong) IBOutlet UIButton *requestButton;
@property (nonatomic) IBOutlet UIActivityIndicatorView *spinnerView;
@property (nonatomic, strong) YASInlineAdView *inlineAd;
@end

@implementation RectangleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Inline Rectangle";
    [self requestInline:nil];
}

- (IBAction)requestInline:(id)sender
{
    [self destroyAd];
    [self uiFetchInProgress:YES];
    self.inlineAdContainer.alpha = 0.0;
    
    self.inlineAd = [[YASInlineAdView alloc] initWithPlacementId:kSampleAppRectangleAdPlacementID];
    self.inlineAd.delegate = self;
    [self.inlineAd loadWithPlacementConfig:nil];
}

- (void)showAd
{
    self.inlineAdContainer.alpha = 0.0;
    self.inlineAd.frame = self.inlineAdContainer.bounds;
    [self.inlineAdContainer addSubview:self.inlineAd];
    
    [UIView animateWithDuration:kFadeInOutDuration animations:^{
        self.inlineAdContainer.alpha = 1.0;
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
    self.inlineAd = inlineAd;
    
    [self uiFetchInProgress:NO];
    
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
    NSLog(@"Inline ad load failed to with error: %@", errorInfo);
    [self uiFetchInProgress:NO];
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
