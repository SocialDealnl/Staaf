//
//  Staaf.swift
//  Staaf
//
//  Created by Rob Hendriks on 28/07/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import UIKit

open class Staaf: UIView {
    
    // MARK: - Properties
    
    open var horizontalAlign: HorizontalAlign = .center {
        didSet { update() }
    }
    
    open var horizontalRatio: CGFloat = 1 {
        didSet { update() }
    }
    
    open var verticalAlign: VerticalAlign = .middle {
        didSet { update() }
    }
    
    open var verticalRatio: CGFloat = 1 {
        didSet { update() }
    }
    
    open var data: StaafData! {
        didSet { /* TODO */ }
    }
    
    fileprivate var ignoreUpdates: Bool = true
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepare()
    }
    
    // MARK: - Methods
    
    fileprivate func prepare() {
        // TODO: initial setup
        
        ignoreUpdates = false
    }
    
    fileprivate func update() {
        guard !ignoreUpdates else { return }
        
        print("update")
    }
    
    open func setup(_ callback: (Staaf) -> ()) {
        ignoreUpdates = true
        callback(self)
        ignoreUpdates = false
        update()
    }
    
    // MARK: - Enums
    
    public enum HorizontalAlign {
        case left
        case center
        case right
    }
    
    public enum VerticalAlign {
        case top
        case middle
        case bottom
    }
}
