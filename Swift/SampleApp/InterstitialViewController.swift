///
/// @file InterstitialViewController.swift
/// @brief Implementation for InterstitialViewController
///
/// @copyright Copyright Yahoo, Licensed under the terms of the Apache 2.0 license . See LICENSE file in project root for terms.
///

import Foundation
import UIKit
import YahooAds

class InterstitialViewController : UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var requestAdButton: UIButton?
    @IBOutlet weak var showButton: UIButton?

    private var ad: YASInterstitialAd?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterstitial(nil)
    }
    
    // MARK: - User Interaction
    
    @IBAction private func loadInterstitial(_ sender: AnyObject?) {
        showButton?.isEnabled = false
        requestAdButton?.isEnabled = false
        
        ad = YASInterstitialAd(placementId: AdPlacementData.interstitialId)
        ad?.delegate = self
        ad?.load(with: nil)
    }

    @IBAction private func displayInterstitial(_ sender: AnyObject) {
        ad?.isImmersiveEnabled = true
        ad?.enterAnimationId = UIModalTransitionStyle.crossDissolve.rawValue
        ad?.exitAnimationId = UIModalTransitionStyle.crossDissolve.rawValue
        ad?.show(from: self)
    }
}

// MARK: - YASInterstitialAdDelegate

extension InterstitialViewController: YASInterstitialAdDelegate {

    func interstitialAdDidLoad(_ interstitialAd: YASInterstitialAd) {
        print("Interstitial ad did load")
        ad = interstitialAd
        
        DispatchQueue.main.async {
            self.showButton?.isEnabled = true
            self.requestAdButton?.isEnabled = true
        }
    }
    
    func interstitialAdLoadDidFail(_ interstitialAd: YASInterstitialAd, withError errorInfo: YASErrorInfo) {
        print("Interstitial ad failed to display with error:  \(errorInfo)")
        ad = nil
        
        DispatchQueue.main.async {
            self.showButton?.isEnabled = false
            self.requestAdButton?.isEnabled = true
        }
    }
    
    func interstitialAdDidFail(_ interstitialAd: YASInterstitialAd, withError errorInfo: YASErrorInfo) {
        print("Interstitial ad failed with error:  \(errorInfo)")
    }
    
    func interstitialAdDidShow(_ interstitialAd: YASInterstitialAd) {
        print("Interstitial ad was shown")
        
        DispatchQueue.main.async {
            self.showButton?.isEnabled = false
            self.requestAdButton?.isEnabled = true
        }
    }
    
    func interstitialAdDidClose(_ interstitialAd: YASInterstitialAd) {
        print("Interstitial ad was closed")
    }
    
    func interstitialAdClicked(_ interstitialAd: YASInterstitialAd) {
        print("Interstitial ad was clicked")

        YahooAudiences.logEvent(YahooAudiencesEvent.adClick, with: nil)
    }
    
    func interstitialAdDidLeaveApplication(_ interstitialAd: YASInterstitialAd) {
        print("Interstitial ad did cause user to leave application")
    }
    
    func interstitialAdEvent(_ interstitialAd: YASInterstitialAd, source: String, eventId: String, arguments: Dictionary<String, Any>?) {
        print("Interstitial ad event occurred with ID: \(eventId)")
    }
}
