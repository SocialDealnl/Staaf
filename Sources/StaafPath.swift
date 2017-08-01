//
//  StaafPath.swift
//  Staaf
//
//  Created by Rob Hendriks on 01/08/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Foundation

public struct StaafPath: CustomStringConvertible {
    
    public var groupIndex: Int
    public var absoluteIndex: Int
    public var relativeIndex: Int
    
    public var description: String {
        return "\(groupIndex) \(absoluteIndex):\(relativeIndex)"
    }
    
    public init(groupIndex: Int, absoluteIndex: Int, relativeIndex: Int) {
        self.groupIndex = groupIndex
        self.absoluteIndex = absoluteIndex
        self.relativeIndex = relativeIndex
    }
    
    public init() {
        self.init(groupIndex: 0, absoluteIndex: 0, relativeIndex: 0)
    }
}
