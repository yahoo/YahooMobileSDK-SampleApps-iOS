///
/// @file RectangleViewController.swift
/// @brief Implementation for RectangleViewController
///
/// @copyright Copyright Yahoo, Licensed under the terms of the Apache 2.0 license . See LICENSE file in project root for terms.
///

import Foundation
import UIKit
import YahooAds

class RectangleViewController : UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var adContainer: UIView?
    @IBOutlet weak var requestAdButton : UIButton?
    @IBOutlet weak var spinnerView: UIActivityIndicatorView?

    private var ad: YASInlineAdView?
    private let fadeInOutDuration = 0.3
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestInline(self)
    }
    
    // MARK: User Interaction
    
    @IBAction func requestInline(_ sender: AnyObject) {
        destroy()

        spinnerView?.startAnimating()
        adContainer?.alpha = 0.0
        requestAdButton?.isEnabled = false
        
        ad =  YASInlineAdView(placementId: AdPlacementData.rectangleId)
        ad?.delegate = self
        ad?.load(with: nil)
    }
    
    func destroy() {
        ad?.removeFromSuperview()
        ad = nil
    }
}

// MARK: - YASInlineAdViewDelegate

extension RectangleViewController: YASInlineAdViewDelegate {
    
    func inlineAdDidLoad(_ inlineAd: YASInlineAdView) {
        print("Inline ad did load")
        ad = inlineAd
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.spinnerView?.stopAnimating()
            if let container = self.adContainer {
                inlineAd.frame = container.bounds
                container.addSubview(inlineAd)
            }
            UIView.animate(withDuration: self.fadeInOutDuration) { [weak self] in
                self?.adContainer?.alpha = 1.0
                self?.requestAdButton?.isEnabled = true
            }
        }
    }
    
    func inlineAdLoadDidFail(_ inlineAd: YASInlineAdView, withError errorInfo: YASErrorInfo) {
        print("Inline ad load failed with error:  \(errorInfo)")
        ad = nil
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.spinnerView?.stopAnimating()
            UIView.animate(withDuration: self.fadeInOutDuration) { [weak self] in
                self?.adContainer?.alpha = 1.0
                self?.requestAdButton?.isEnabled = true
            }
        }
    }
    
    func inlineAdPresentingViewController() -> UIViewController? {
        return self
    }

    func inlineAd(_ inlineAd: YASInlineAdView, event eventId: String, source: String, arguments: [String : Any]) {
        print("Inline ad event occurred with ID: \(eventId)")
    }

    func inlineAdDidFail(_ inlineAd: YASInlineAdView, withError errorInfo: YASErrorInfo) {
        print("Inline ad failed to display with error:  \(errorInfo)")
    }
    
    func inlineAdDidExpand(_ inlineAd: YASInlineAdView) {
        print("Inline ad expanded")
    }
    
    func inlineAdDidCollapse(_ inlineAd: YASInlineAdView) {
        print("Inline ad collapsed")
    }
    
    func inlineAdClicked(_ inlineAd: YASInlineAdView) {
        print("Inline ad clicked")
        
        YahooAudiences.logEvent(YahooAudiencesEvent.adClick, with: nil)
    }
    
    func inlineAdDidLeaveApplication(_ inlineAd: YASInlineAdView) {
        print("Inline ad did cause user to leave application")
    }
    
    func inlineAdDidResize(_ inlineAd: YASInlineAdView) {
        print("Inline ad did resize")
    }
    
    func inlineAdDidRefresh(_ inlineAd: YASInlineAdView) {
        print("Inline ad did refresh")
    }
}
