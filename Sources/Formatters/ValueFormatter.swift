//
//  ValueFormatter.swift
//  Staaf
//
//  Created by Rob Hendriks on 31/07/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import Foundation

public protocol ValueFormatter {
    
    func format(_ value: Staaf.Value) -> String
}
