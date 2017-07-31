//
//  OddEvenColorStrategy.swift
//  Staaf
//
//  Created by Rob Hendriks on 31/07/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Foundation

public struct OddEvenColorStrategy: ColorStrategy {
    
    fileprivate let oddColor: UIColor
    fileprivate let evenColor: UIColor
    
    public init(_ oddColor: UIColor = UIColor.lightGray, _ evenColor: UIColor = UIColor.darkGray) {
        self.oddColor = oddColor
        self.evenColor = evenColor
    }
    
    public func color(at index: Int) -> UIColor {
        return index % 2 == 0 ? evenColor : oddColor
    }
}
