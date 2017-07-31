//
//  TextCacheable.swift
//  Staaf
//
//  Created by Rob Hendriks on 31/07/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Foundation

internal protocol TextCacheable {
    
    func text(_ formatter: ValueFormatter) -> [String]
}

extension TextCacheable {
    
    internal func cache(_ cache: inout TextCache, formatter: ValueFormatter, attributes: TextAttributes) {
        if cache.clearOnUpdate {
            cache.items.removeAll()
        }
        
        cache.maximumSize = .zero
        
        for text in text(formatter) {
            let string: NSString = NSString(string: text)
            let size: CGSize = string.size(attributes: attributes)
            
            if size.width > cache.maximumSize.width {
                cache.maximumSize.width = size.width
            }
            if size.height > cache.maximumSize.height {
                cache.maximumSize.height = size.height
            }
            
            cache.items.append(TextCacheItem(string, size))
        }
    }
}
