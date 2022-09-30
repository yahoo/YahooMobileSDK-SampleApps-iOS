///
/// @file AppDelegate.swift
/// @brief Implementation for AppDelegate
///
/// @copyright Copyright Yahoo, Licensed under the terms of the Apache 2.0 license . See LICENSE file in project root for terms.
///

import Foundation
import UIKit
import YahooAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupGlobalAppearance()
        setupPlacementConfigurations()
        
        // Required for all integrations
        YASAds.logLevel = .debug
        YASAds.initialize(withSiteId: "8a809418014d4dba274de5017840037f")
        
        return true
    }
    
    func setupGlobalAppearance() {
        guard
            let navBar = (window?.rootViewController as? UINavigationController)?.navigationBar,
            let font = UIFont(name: "AvenirNext-DemiBold", size: 16.0)
        else {
            return
        }
        
        let yahooPurple =  UIColor(red: 122.0/255, green: 32.0/255.0, blue: 230.0/255, alpha: 1)
        
        navBar.barTintColor = yahooPurple
        
        navBar.titleTextAttributes = [
            .font: font,
            .foregroundColor: UIColor.white
        ]
        UIBarButtonItem.appearance().setTitleTextAttributes([
            .font: font,
            .foregroundColor: UIColor.white
        ], for: .normal)
        UIBarButtonItem.appearance().tintColor = .white
        
        UIButton.appearance().tintColor = yahooPurple
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            
            appearance.titleTextAttributes = [ .font: font, .foregroundColor: UIColor.white]
            appearance.backgroundColor = yahooPurple
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    private func setupPlacementConfigurations() {
        let manager = YASUnifiedAdManager.sharedInstance
        
        // Banner
        manager.setPlacementConfig(
            YASInlinePlacementConfig(placementId: AdPlacementData.bannerId,
                                     requestMetadata: nil,
                                     adSizes: AdPlacementData.bannerSizes),
            forPlacementId: AdPlacementData.bannerId)
        
        // Rectangle
        manager.setPlacementConfig(
            YASInlinePlacementConfig(placementId: AdPlacementData.rectangleId,
                                     requestMetadata: nil,
                                     adSizes: AdPlacementData.rectangleSizes),
            forPlacementId: AdPlacementData.rectangleId)
        
        // Interstitial
        manager.setPlacementConfig(
            YASInterstitialPlacementConfig(placementId: AdPlacementData.interstitialId, requestMetadata: nil),
            forPlacementId: AdPlacementData.interstitialId)
        
        // Native
        manager.setPlacementConfig(
            YASNativePlacementConfig(placementId: AdPlacementData.nativeId,
                                     requestMetadata: nil,
                                     nativeAdTypes: AdPlacementData.nativeTypes),
            forPlacementId: AdPlacementData.nativeId)
    }
}
