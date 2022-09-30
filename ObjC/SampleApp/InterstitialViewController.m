///
/// @file InterstitialViewController.m
/// @brief Implementation for InterstitialViewController
///
/// @copyright Copyright Yahoo, Licensed under the terms of the Apache 2.0 license . See LICENSE file in project root for terms.
///

#import "InterstitialViewController.h"
#import "AdPlacementConsts.h"
#import <YahooAds/YahooAds.h>

@interface InterstitialViewController () <YASInterstitialAdDelegate>

@property (nonatomic, strong) IBOutlet UIButton *requestButton;
@property (nonatomic, strong) IBOutlet UIButton *showButton;
@property (nonatomic, strong) YASInterstitialAd *interstitialAd;

@end

@implementation InterstitialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.showButton setEnabled:NO];
}

- (IBAction)loadInterstitial:(id)sender
{
    [self.showButton setEnabled:NO];
    self.interstitialAd = [[YASInterstitialAd alloc] initWithPlacementId:kSampleAppInterstitialAdPlacementID];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadWithPlacementConfig:nil];
}

- (IBAction)displayInterstitial:(id)sender
{
    [self.interstitialAd setImmersiveEnabled:YES];
    [self.interstitialAd setEnterAnimationId:UIModalTransitionStyleCrossDissolve];
    [self.interstitialAd setExitAnimationId:UIModalTransitionStyleCrossDissolve];
    [self.interstitialAd showFromViewController:self];
}

#pragma mark - YASInterstitialAdDelegate

- (void)interstitialAdDidLoad:(YASInterstitialAd *)interstitialAd
{
    NSLog(@"Interstitial ad did load");
    self.interstitialAd = interstitialAd;
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        strongSelf.showButton.enabled = YES;
    });
}

- (void)interstitialAdLoadDidFail:(YASInterstitialAd *)interstitialAd withError:(YASErrorInfo *)errorInfo
{
    NSLog(@"Interstitial ad load failed with error: %@", errorInfo);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.showButton setEnabled:NO];
    });
}

- (void)interstitialAdDidFail:(YASInterstitialAd *)interstitialAd withError:(YASErrorInfo *)errorInfo
{
    NSLog(@"Interstitial ad failed to display with error: %@", errorInfo);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.showButton setEnabled:NO];
    });
}

- (void)interstitialAdDidShow:(YASInterstitialAd *)interstitialAd
{
    NSLog(@"Interstitial ad was shown");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.showButton setEnabled:NO];
    });
}

- (void)interstitialAdDidClose:(YASInterstitialAd *)interstitialAd
{
    NSLog(@"Interstitial ad was closed");
}

- (void)interstitialAdClicked:(YASInterstitialAd *)interstitialAd
{
    NSLog(@"Interstitial ad was clicked");
    [YahooAudiences logEventWithEventType:YahooAudiencesEventAdClick andParamBuilder:nil];
}

- (void)interstitialAdDidLeaveApplication:(YASInterstitialAd *)interstitialAd
{
    NSLog(@"Interstitial ad did cause user to leave application");
}

- (void)interstitialAdEvent:(YASInterstitialAd *)interstitialAd source:(NSString *)source eventId:(NSString *)eventId arguments:(NSDictionary<NSString *, id> *)arguments
{
    NSLog(@"Interstitial ad event occurred with ID: %@", eventId);
}

@end
