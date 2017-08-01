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
    @IBOutlet weak var distributionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var colorSegmentedControl: UISegmentedControl!
    @IBOutlet weak var colorModeSegmentedControl: UISegmentedControl!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupStaaf()
        randomize(self)
    }
    
    
    // MARK: - Methods
    
    fileprivate func setupUI() {
        distributionSegmentedControl.addTarget(self, action: #selector(distributionChanged(_:)), for: .valueChanged)
        colorSegmentedControl.addTarget(self, action: #selector(colorChanged(_:)), for: .valueChanged)
        colorModeSegmentedControl.addTarget(self, action: #selector(colorModeChanged(_:)), for: .valueChanged)
    }
    
    fileprivate func setupStaaf() {
        staaf.setup { (staaf: Staaf) -> Void in
            // Configure y-axis
            staaf.minimumValue = 0
//            staaf.maximumValue = 100
            
            // Configure groups and bars
            staaf.barSpacing = 5
            staaf.barOffset = 5
            staaf.groupDistribution = .proportionally
            staaf.groupSpacing = 15
            
            // Configure group labels
            staaf.groupLabelFont = UIFont.systemFont(ofSize: 9)
            staaf.groupLabelColor = UIColor.gray
            staaf.groupLabelOffset = 5
            
            // Configure value labels
            staaf.valueLabelFont = UIFont.systemFont(ofSize: 7)
            staaf.valueLabelColor = UIColor.lightGray
            staaf.valueLabelOffset = 3
            
            // Configure border
            staaf.borderWidth = 0.5
            staaf.borderColor = UIColor.lightGray
            
            // Configure value formatting
            staaf.valueFormatter = WholeNumberFormatter()
//            staaf.valueFormatter = DecimalFormatter(2)
            
            distributionChanged(self)
            colorChanged(self)
            colorModeChanged(self)
        }
    }
    
    @objc fileprivate func distributionChanged(_ sender: Any) {
        staaf.groupDistribution = distribution(for: distributionSegmentedControl.selectedSegmentIndex)
    }
    
    @objc fileprivate func colorChanged(_ sender: Any) {
        var strategy: ColorStrategy = colorStrategy(for: colorSegmentedControl.selectedSegmentIndex)
        strategy.mode = colorMode(for: colorModeSegmentedControl.selectedSegmentIndex)
        staaf.colorStrategy = strategy
    }
    
    @objc fileprivate func colorModeChanged(_ sender: Any) {
        staaf.colorStrategy.mode = colorMode(for: colorModeSegmentedControl.selectedSegmentIndex)
        staaf.setNeedsDisplay()
    }
    
    fileprivate func distribution(for index: Int) -> Staaf.Distribution {
        switch index {
        case 0:
            return .proportionally
        default:
            return .equally
        }
    }
    
    fileprivate func colorStrategy(for index: Int) -> ColorStrategy {
        switch index {
        case 0:
            return SingleColorStrategy(UIColor.cyan)
        case 1:
            return OddEvenColorStrategy(UIColor.purple, UIColor.magenta)
        default:
            return RainbowColorStrategy([UIColor.red, UIColor.green, UIColor.blue, UIColor.yellow, UIColor.cyan, UIColor.magenta])
        }
    }
    
    fileprivate func colorMode(for index: Int) -> ColorStrategyMode {
        switch index {
        case 0:
            return .absolute
        case 1:
            return .relative
        default:
            return .group
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func randomize(_ sender: Any) {
        let labels: [String] = ["Group A", "Group B", "Group C", "Group D"]
        
        var groups: [StaafDataGroup] = []
        
        for label in labels {
            let numberOfValues: Int = Int(arc4random_uniform(4) + 1)
            var values: [Double] = []
            
            for _ in 0..<numberOfValues {
                values.append(Double(arc4random_uniform(100) + 1))
            }
            
            groups.append(StaafDataGroup(values, label: label))
        }
        
        staaf.setup { (staaf: Staaf) -> Void in
            staaf.data = StaafData(groups)
        }
    }
}

