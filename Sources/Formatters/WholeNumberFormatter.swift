//
//  WholeNumberFormatter.swift
//  Staaf
//
//  Created by Rob Hendriks on 31/07/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Foundation

public struct WholeNumberFormatter: ValueFormatter {
    
    public init() {}
    
    public func format(_ value: Staaf.Value) -> String {
        return String(format: "%.0f", value)
    }
}
