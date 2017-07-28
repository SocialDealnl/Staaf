//
//  StaafData.swift
//  Staaf
//
//  Created by Rob Hendriks on 28/07/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Foundation

public struct StaafData {
    
    public let groups: [StaafDataGroup]
    public let minimumValue: Double
    public let maximumValue: Double
    
    public init(_ groups: [StaafDataGroup]) {
        self.groups = groups
        
        self.minimumValue = groups.min()
        self.maximumValue = groups.max()
    }
}
