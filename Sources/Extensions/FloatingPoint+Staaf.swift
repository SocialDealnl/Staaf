//
//  FloatingPoint+Staaf.swift
//  Staaf
//
//  Created by Rob Hendriks on 31/07/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Foundation

extension FloatingPoint {
    
    internal func normalize(to range: ClosedRange<Self>) -> Self {
        return (self - range.lowerBound) / (range.upperBound - range.lowerBound)
    }
}
