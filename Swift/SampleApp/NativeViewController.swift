///
/// @file NativeAccessorViewController.swift
/// @brief Implementation of NativeAccessorViewController
///
/// @copyright Copyright Yahoo, Licensed under the terms of the Apache 2.0 license . See LICENSE file in project root for terms.
///

import UIKit
import YahooAds

class NativeViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var requestAdButton: UIButton?
    @IBOutlet weak var showButton: UIButton?
    @IBOutlet weak var adContainer: NativeAdContainer?
    @IBOutlet weak var spinner: UIActivityIndicatorView?

    private let fadeInOutDuration = 0.3
    private var ad : YASNativeAd?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        requestAd(nil)
    }

    // MARK: - User Interaction

    @IBAction func requestAd(_ sender: AnyObject?) {
        adContainer?.alpha = 0.0
        requestAdButton?.isEnabled = false
        showButton?.isEnabled = false
        spinner?.startAnimating()
        ad?.destroy()
        
        ad = YASNativeAd(placementId: AdPlacementData.nativeId)
        ad?.delegate = self
        ad?.load(with: nil)
    }

    @IBAction func showAd(_ sender: AnyObject?) {
        guard let ad = ad else { return }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.showButton?.isEnabled = false
            self.adContainer?.setupWith(nativeAd: ad)

            UIView.animate(withDuration: self.fadeInOutDuration) { [weak self] in
                self?.adContainer?.alpha = 1.0
                self?.requestAdButton?.isEnabled = true
            }
        }
    }

    @IBAction func adTapped(_ sender: AnyObject) {
        ad?.invokeDefaultAction()
    }
}

// MARK: - YASNativeAdDelegate

extension NativeViewController: YASNativeAdDelegate {

    func nativeAdDidLoad(_ nativeAd: YASNativeAd) {
        print("Native ad did load")
        ad = nativeAd
        
        DispatchQueue.main.async {
            self.showButton?.isEnabled = true
            self.requestAdButton?.isEnabled = true
            self.spinner?.stopAnimating()
        }
    }
    
    func nativeAdLoadDidFail(_ nativeAd: YASNativeAd, withError errorInfo: YASErrorInfo) {
        print("Load native ad failed with error:  \(errorInfo)")
        ad = nil
        
        DispatchQueue.main.async {
            self.spinner?.stopAnimating()

            self.showButton?.isEnabled = false
            self.requestAdButton?.isEnabled = true
        }
    }
    
    func nativeAdDidFail(_ nativeAd: YASNativeAd, withError errorInfo: YASErrorInfo) {
        print("Native ad failed with error: \(errorInfo)")
    }

    func nativeAdDidClose(_ nativeAd: YASNativeAd) {
        print("Native ad did close")
    }

    func nativeAdClicked(_ nativeAd: YASNativeAd, with component: YASNativeComponent) {
        print("Native ad clicked")

        YahooAudiences.logEvent(YahooAudiencesEvent.adClick, with: nil)
    }

    func nativeAdDidLeaveApplication(_ nativeAd: YASNativeAd) {
        print("Native ad caused user to leave application")
    }

    func nativeAd(_ nativeAd: YASNativeAd, event eventId: String, source: String, arguments: [String : Any]) {
        print("Native event occurred with ID:  \(eventId)")
    }

    func nativeAdPresentingViewController() -> UIViewController? {
        return self
    }
}
