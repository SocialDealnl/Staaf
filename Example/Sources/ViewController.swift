//
//  ViewController.swift
//  iOS Example
//
//  Created by Rob Hendriks on 28/07/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import UIKit
import Staaf

class ViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var staaf: Staaf!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let a = StaafDataGroup([21, 19], label: "Groep A")
        let b = StaafDataGroup([7, 11], label: "Groep B")
        let c = StaafDataGroup([15, 17], label: "Groep C")
        let d = StaafDataGroup([13, 23], label: "Groep D")
        
        let data = StaafData([a, b, c, d])
        
        staaf.setup { (staaf: Staaf) -> Void in
            staaf.minimumValue = 0
            
            staaf.barSpacing = 8
            staaf.groupSpacing = 24
            
            staaf.borderWidth = 0.5
            
            staaf.valueFormatter = WholeNumberFormatter()
            
            staaf.colorStrategy = OddEvenColorStrategy(UIColor.lightGray, UIColor.blue)
            
            staaf.data = data
        }
    }
}

