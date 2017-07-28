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
    
        let a = StaafDataGroup([], label: "A")
        let b = StaafDataGroup([], label: "A")
        let data = StaafData([a, b])
        dump(data)
        
        staaf.setup { (staaf: Staaf) -> Void in
            staaf.horizontalAlign = .center
            staaf.horizontalRatio = 0.5
        
            staaf.verticalAlign = .middle
            staaf.verticalRatio = 0.75
            
            
        }
    }
}

