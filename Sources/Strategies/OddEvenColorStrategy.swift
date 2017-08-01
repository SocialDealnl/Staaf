//
//  OddEvenColorStrategy.swift
//  Staaf
//
//  Created by Rob Hendriks on 31/07/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import UIKit

public struct OddEvenColorStrategy: ColorStrategy {
    
    public var mode: ColorStrategyMode = .relative
    
    fileprivate let oddColor: UIColor
    fileprivate let evenColor: UIColor
    
    public init(_ oddColor: UIColor = UIColor.lightGray, _ evenColor: UIColor = UIColor.darkGray) {
        self.oddColor = oddColor
        self.evenColor = evenColor
    }
    
    public func color(for path: StaafPath) -> UIColor {
        return index(path) % 2 == 0 ? evenColor : oddColor
    }
}
