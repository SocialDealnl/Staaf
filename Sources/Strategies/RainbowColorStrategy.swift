//
//  RainbowColorStrategy.swift
//  Staaf
//
//  Created by Rob Hendriks on 01/08/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import UIKit

public struct RainbowColorStrategy: ColorStrategy {
    
    public var mode: ColorStrategyMode = .relative
    
    fileprivate let colors: [UIColor]
    fileprivate let colorCount: Int
    
    public init(_ colors: [UIColor]) {
        if colors.isEmpty {
            fatalError("Color array cannot be empty")
        }
        self.colors = colors
        self.colorCount = colors.count
    }
    
    public func color(for path: StaafPath) -> UIColor {
        let colorIndex: Int = index(path) % colorCount
        return colors[colorIndex]
    }
}
