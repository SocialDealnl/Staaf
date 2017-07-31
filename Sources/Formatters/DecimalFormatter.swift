//
//  DecimalFormatter.swift
//  Staaf
//
//  Created by Rob Hendriks on 31/07/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Foundation

public struct DecimalFormatter: ValueFormatter {
    
    fileprivate let decimals: UInt8
    
    public init(_ decimals: UInt8 = 2) {
        self.decimals = decimals
    }
    
    public func format(_ value: Staaf.Value) -> String {
        return String(format: "%.\(decimals)f", value)
    }
}
