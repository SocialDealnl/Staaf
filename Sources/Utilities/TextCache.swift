//
//  TextCache.swift
//  Staaf
//
//  Created by Rob Hendriks on 31/07/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Foundation

internal typealias TextCacheItem = (string: NSString, size: CGSize)
internal typealias TextAttributes = [String: Any]

internal struct TextCache {
    
    internal var items: [TextCacheItem] = []
    internal var maximumSize: CGSize = .zero
    internal var clearOnUpdate: Bool = true
}
