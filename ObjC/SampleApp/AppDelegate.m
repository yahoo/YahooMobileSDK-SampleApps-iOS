///
///  @file
///  @brief Implementation for AppDelegate
///
///  @copyright Copyright Yahoo, Licensed under the terms of the Apache 2.0 license . See LICENSE file in project root for terms.
///

#import "AppDelegate.h"
#import "AdPlacementConsts.h"
#import <YahooAds/YahooAds.h>

NSString * const kSampleAppSiteId = @"8a809418014d4dba274de5017840037f";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupGlobalAppearance];
    [self setupPlacementConfigurations];

    // Required for all integrations
    YASAds.logLevel = YASLogLevelDebug;
    [YASAds initializeWithSiteId:kSampleAppSiteId];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Ad Placement Configurations

- (void)setupPlacementConfigurations
{
    YASUnifiedAdManager *adManager = YASUnifiedAdManager.sharedInstance;
    YASInlineAdSize *bannerSize = [[YASInlineAdSize alloc] initWithWidth:320 height:50];
    YASInlineAdSize *rectangleSize = [[YASInlineAdSize alloc] initWithWidth:300 height:250];
    
    YASInlinePlacementConfig *inlineBannerConfig = [[YASInlinePlacementConfig alloc] initWithPlacementId:kSampleAppBannerAdPlacementID requestMetadata:nil adSizes:@[bannerSize]];
    
    YASInlinePlacementConfig *inlineRectConfig = [[YASInlinePlacementConfig alloc] initWithPlacementId:kSampleAppRectangleAdPlacementID requestMetadata:nil adSizes:@[rectangleSize]];
    
    YASInterstitialPlacementConfig *interstitialConfig = [[YASInterstitialPlacementConfig alloc] initWithPlacementId:kSampleAppInterstitialAdPlacementID requestMetadata:nil];
    
    YASNativePlacementConfig *nativeConfig = [[YASNativePlacementConfig alloc] initWithPlacementId:kSampleAppNativeAdPlacementID requestMetadata:nil nativeAdTypes:@[@"simpleImage", @"simpleVideo"]];
    
    [adManager setPlacementConfig:inlineBannerConfig forPlacementId:kSampleAppBannerAdPlacementID];
    [adManager setPlacementConfig:inlineRectConfig forPlacementId:kSampleAppRectangleAdPlacementID];
    [adManager setPlacementConfig:interstitialConfig forPlacementId:kSampleAppInterstitialAdPlacementID];
    [adManager setPlacementConfig:nativeConfig forPlacementId:kSampleAppNativeAdPlacementID];
}

#pragma mark - App Appearance

- (void)setupGlobalAppearance {
    UINavigationBar *navigationBar = [(UINavigationController *)self.window.rootViewController navigationBar];
    
    UIColor *yahooPurple  = [UIColor colorWithRed:122.0/255 green:32.0/255 blue:230.0/255 alpha:1.0];
    [navigationBar setBarTintColor:yahooPurple];
    [navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-DemiBold" size:18.0], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-DemiBold" size:16.0]} forState:UIControlStateNormal];
    
    [[UIButton appearance] setTintColor:yahooPurple];
    
    if (@available(iOS 15, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        
        appearance.titleTextAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-DemiBold" size:18.0], NSForegroundColorAttributeName: [UIColor whiteColor]};
        appearance.backgroundColor = yahooPurple;
        
        [UINavigationBar appearance].standardAppearance = appearance;
        [UINavigationBar appearance].scrollEdgeAppearance = appearance;
    }
}

@end
