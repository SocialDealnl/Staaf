//
//  StaafDataGroup.swift
//  Staaf
//
//  Created by Rob Hendriks on 28/07/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Foundation

public struct StaafDataGroup: TextCacheable {
 
    public let label: String?
    public let values: [Staaf.Value]
    public let valueCount: Int
    public let minimumValue: Staaf.Value
    public let maximumValue: Staaf.Value
    
    internal var textCache: TextCache = TextCache()
    
    public init(_ values: [Staaf.Value], label: String? = nil) {
        self.label = label
        self.values = values
        self.valueCount = values.count
        self.minimumValue = values.min() ?? 0
        self.maximumValue = values.max() ?? 0
    }
    
    internal func text(_ formatter: ValueFormatter) -> [String] {
        return values.map { (value: Staaf.Value) -> String in
            return formatter.format(value)
        }
    }
}
