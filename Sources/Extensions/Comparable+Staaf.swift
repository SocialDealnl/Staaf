//
//  Comparable+Staaf.swift
//  Staaf
//
//  Created by Rob Hendriks on 31/07/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Foundation

extension Comparable {
    
    internal func clamp(to range: ClosedRange<Self>) -> Self {
        return max(min(range.upperBound, self), range.lowerBound)
    }
}
