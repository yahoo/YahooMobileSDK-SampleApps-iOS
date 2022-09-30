///
/// @file NativeAdContainer.swift
/// @brief Implementation of NativeAdContainer
///
/// @copyright Copyright Yahoo, Licensed under the terms of the Apache 2.0 license . See LICENSE file in project root for terms.
///

import UIKit
import YahooAds

class NativeAdContainer : UIView {
    
    // MARK: - Properties

    @IBOutlet weak var bodyLabel: UILabel?
    @IBOutlet weak var ctaButton: UIButton?
    @IBOutlet weak var disclaimerLabel: UILabel?
    @IBOutlet weak var iconImageView: UIImageView?
    @IBOutlet weak var mainImageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    
    // MARK: - Functions
    
    func setupWith(nativeAd: YASNativeAd) {
        if let iconComponent = nativeAd.component("iconImage") as? YASNativeImageComponent,
           let iconImageView = iconImageView {
            iconComponent.prepare(iconImageView)
        }
        
        if let titleComponent = nativeAd.component("title") as? YASNativeTextComponent,
           let titleLabel = titleLabel {
            titleComponent.prepare(titleLabel)
        }
        
        if let bodyComponent = nativeAd.component("body") as? YASNativeTextComponent,
           let bodyLabel = bodyLabel {
            bodyComponent.prepare(bodyLabel)
        }
        
        if let ctaComponent = nativeAd.component("callToAction") as? YASNativeTextComponent,
           let ctaButton = ctaButton {
            ctaComponent.prepare(ctaButton)
        }
        
        if let mainImageComponent = nativeAd.component("mainImage") as? YASNativeImageComponent,
           let mainImageView = mainImageView {
            mainImageComponent.prepare(mainImageView)
        }
        
        if let disclaimerComponent = nativeAd.component("disclaimer") as? YASNativeTextComponent,
           let disclaimerLabel = disclaimerLabel {
            disclaimerComponent.prepare(disclaimerLabel)
        }
        
        nativeAd.registerContainerView(self)
    }
    
    private func anchor(subview:UIView, to superview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: superview, attribute: .top, relatedBy: .equal, toItem: subview, attribute: .top, multiplier: 1.0, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: superview, attribute: .bottom, relatedBy: .equal, toItem: subview, attribute: .bottom, multiplier: 1.0, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: superview, attribute: .leading, relatedBy: .equal, toItem: subview, attribute: .leading, multiplier: 1.0, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: superview, attribute: .trailing, relatedBy: .equal, toItem: subview, attribute: .trailing, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([topConstraint, bottomConstraint, trailingConstraint, leadingConstraint])
    }
}
