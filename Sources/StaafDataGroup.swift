//
//  StaafDataGroup.swift
//  Staaf
//
//  Created by Rob Hendriks on 28/07/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Foundation

public struct StaafDataGroup {
 
    public let label: String?
    public let values: [Double]
    public let minimumValue: Double
    public let maximumValue: Double
    
    public init(_ values: [Double], label: String? = nil) {
        self.label = label
        self.values = values
        self.minimumValue = values.min() ?? 0
        self.maximumValue = values.max() ?? 0
    }
}
