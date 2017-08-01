//
//  ColorStrategy.swift
//  Staaf
//
//  Created by Rob Hendriks on 31/07/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import UIKit

public protocol ColorStrategy {
    
    // MARK: - Properties
    
    var mode: ColorStrategyMode { get set }
    
    
    // MARK: - Methods
    
    func color(for path: StaafPath) -> UIColor
}

extension ColorStrategy {
    
    func index(_ path: StaafPath) -> Int {
        switch mode {
        case .absolute:
            return path.absoluteIndex
        case .relative:
            return path.relativeIndex
        case .group:
            return path.groupIndex
        }
    }
}
