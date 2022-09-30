///
/// @file AdPlacementData.swift
/// @brief Ad placement data structure containing placement ids, sizes, etc.
///
/// @copyright Copyright Yahoo, Licensed under the terms of the Apache 2.0 license . See LICENSE file in project root for terms.
///

import Foundation
import YahooAds

struct AdPlacementData {
    
    static let bannerId = "240372"
    static let bannerSizes = [YASInlineAdSize(width: 320, height: 50)]
    
    static let rectangleId = "240379"
    static let rectangleSizes = [YASInlineAdSize(width: 300, height: 250)]
    
    static let interstitialId = "240383"
    
    static let nativeId = "240549"
    static let nativeTypes = ["simpleImage", "simpleVideo"]
}
