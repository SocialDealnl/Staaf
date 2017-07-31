//
//  StaafData.swift
//  Staaf
//
//  Created by Rob Hendriks on 28/07/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Foundation

public struct StaafData: TextCacheable {
    
    public let groups: [StaafDataGroup]
    public let groupCount: Int
    public let minimumValue: Staaf.Value
    public let maximumValue: Staaf.Value
    
    var barCount: Int {
        return groups.reduce(0) { (result: Int, group: StaafDataGroup) -> Int in
            return result + group.valueCount
        }
    }
    
    public init(_ groups: [StaafDataGroup]) {
        self.groups = groups
        self.groupCount = groups.count
        self.minimumValue = groups.min()
        self.maximumValue = groups.max()
    }
    
    internal func text(_ formatter: ValueFormatter) -> [String] {
        return groups.map { (group: StaafDataGroup) -> String in
            return group.label ?? ""
        }
    }
}
