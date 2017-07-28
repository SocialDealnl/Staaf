//
//  Array+Staaf.swift
//  Staaf
//
//  Created by Rob Hendriks on 28/07/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Foundation

extension Array where Element == StaafDataGroup {
    
    internal func min() -> Double {
        let group = self.min { (a: StaafDataGroup, b: StaafDataGroup) -> Bool in
            return a.minimumValue < b.minimumValue
        }
        
        return group?.maximumValue ?? 0
    }
    
    internal func max() -> Double {
        let group = self.max { (a: StaafDataGroup, b: StaafDataGroup) -> Bool in
            return a.maximumValue < b.maximumValue
        }
        
        return group?.maximumValue ?? 0
    }
}
