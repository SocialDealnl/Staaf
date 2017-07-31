//
//  SingleColorStrategy.swift
//  Staaf
//
//  Created by Rob Hendriks on 31/07/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Foundation

public struct SingleColorStrategy: ColorStrategy {
    
    fileprivate let baseColor: UIColor
    
    public init(_ baseColor: UIColor = UIColor.gray) {
        self.baseColor = baseColor
    }
    
    public func color(at index: Int) -> UIColor {
        return baseColor
    }
}
