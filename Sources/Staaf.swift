//
//  Staaf.swift
//  Staaf
//
//  Created by Rob Hendriks on 28/07/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import UIKit

open class Staaf: UIView {
    public typealias Value = Double
    
    fileprivate typealias Cache = (groupWidth: CGFloat, barWidth: CGFloat)
    
    // MARK: - Properties
    
    open var borderColor: UIColor = UIColor.lightGray {
        didSet { setNeedsDisplay() }
    }
    
    open var borderWidth: CGFloat = 0 {
        didSet { setNeedsDisplay() }
    }
    
    ///
    
    open var groupSpacing: CGFloat = 15 {
        didSet {
            groupSpacing = max(0, groupSpacing)
            setNeedsDisplay()
        }
    }
    
    open var groupDistribution: Distribution = .proportionally {
        didSet {
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    ///
    
    open var barSpacing: CGFloat = 5 {
        didSet {
            barSpacing = max(0, barSpacing)
            setNeedsLayout()
        }
    }
    
    open var barOffset: CGFloat = 3 {
        didSet {
            barOffset = max(0, barOffset)
            setNeedsLayout()
        }
    }
    
    ///
    
    open var valueFormatter: ValueFormatter = WholeNumberFormatter() {
        didSet { updateValueTextCache() }
    }
    
    open var valueLabelFont: UIFont = UIFont.systemFont(ofSize: 7) {
        didSet { updateValueTextAttributes() }
    }
    
    open var valueLabelColor: UIColor = UIColor.darkGray {
        didSet { updateValueTextAttributes() }
    }
    
    open var valueLabelOffset: CGFloat = 3 {
        didSet {
            valueLabelOffset = max(0, valueLabelOffset)
            setNeedsDisplay()
        }
    }
    
    ///
    
    open var groupLabelFont: UIFont = UIFont.systemFont(ofSize: 9) {
        didSet { updateGroupTextAttributes() }
    }
    
    open var groupLabelColor: UIColor = UIColor.darkGray {
        didSet { updateGroupTextAttributes() }
    }
    
    open var groupLabelOffset: CGFloat = 3 {
        didSet {
            groupLabelOffset = max(0, groupLabelOffset)
            setNeedsDisplay()
        }
    }
    
    ///
    
    open var colorStrategy: ColorStrategy = SingleColorStrategy() {
        didSet { setNeedsDisplay() }
    }
    
    ///
    
    open var data: StaafData? {
        didSet {
            updateGroupTextAttributes()
            updateValueTextAttributes()
            
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    open var minimumValue: Value? {
        didSet { setNeedsDisplay() }
    }
    
    open var maximumValue: Value? {
        didSet { setNeedsDisplay() }
    }

    fileprivate var cache: [Cache]!
    
    fileprivate var valueTextCache: TextCache = TextCache()
    fileprivate var valueTextAttributes: TextAttributes!
    
    fileprivate var groupTextCache: TextCache = TextCache()
    fileprivate var groupTextAttributes: TextAttributes!
    
    fileprivate var ignoreUpdates: Bool = false
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        //
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        //
    }
    
    // MARK: - Methods
    
    fileprivate func updateValueTextAttributes() {
        guard !ignoreUpdates else { return }
        
        valueTextAttributes = [
            NSFontAttributeName: valueLabelFont,
            NSForegroundColorAttributeName: valueLabelColor
        ]
        
        updateValueTextCache()
    }
    
    fileprivate func updateValueTextCache() {
        guard !ignoreUpdates, let data = data else { return }
        
        valueTextCache.items.removeAll()
        valueTextCache.clearOnUpdate = false
        
        for group in data.groups {
            group.cache(&valueTextCache, formatter: valueFormatter, attributes: valueTextAttributes)
        }
        
        valueTextCache.clearOnUpdate = true
    }
    
    fileprivate func updateGroupTextAttributes() {
        guard !ignoreUpdates else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        
        groupTextAttributes = [
            NSFontAttributeName: groupLabelFont,
            NSForegroundColorAttributeName: groupLabelColor,
            NSParagraphStyleAttributeName: paragraphStyle
        ]
        
        updateGroupTextCache()
    }
    
    fileprivate func updateGroupTextCache() {
        guard !ignoreUpdates, let data = data else { return }
        
        data.cache(&groupTextCache, formatter: valueFormatter, attributes: groupTextAttributes)
    }
        
    open func setup(_ callback: (Staaf) -> ()) {
        ignoreUpdates = true
        callback(self)
        ignoreUpdates = false
        
        updateGroupTextAttributes()
        updateValueTextAttributes()
        
        setNeedsLayout()
        setNeedsDisplay()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if let data = data {
            let rect = bounds
            
            let width: CGFloat = rect.width
            let totalGroupSpacing: CGFloat = CGFloat(data.groupCount + 1) * groupSpacing
            let availableGroupWidth: CGFloat = width - totalGroupSpacing
            
            // Distribute
            let totalGroupCount: Int = data.groupCount
            let totalBarCount: Int = data.barCount
            
            cache = [Cache](repeating: (0, 0), count: totalGroupCount)
            
            for i in 0..<totalGroupCount {
                let barCount: Int = data.groups[i].valueCount
                
                let groupWidthMultiplier: CGFloat = groupDistribution.distribute(barCount, totalBarCount, totalGroupCount)
                let groupWidth: CGFloat = availableGroupWidth * groupWidthMultiplier
                
                let totalBarSpacing: CGFloat = CGFloat(barCount - 1) * barSpacing
                let availableBarWidth: CGFloat = groupWidth - totalBarSpacing
                let barWidth: CGFloat = availableBarWidth / CGFloat(barCount)
                
                cache[i] = (groupWidth, barWidth)
            }
        } else {
            
        }
    }
    
    open override func setNeedsDisplay() {
        guard !ignoreUpdates else { return }
        super.setNeedsDisplay()
        
        print("draw")
    }
    
    open override func setNeedsLayout() {
        guard !ignoreUpdates else { return }
        super.setNeedsLayout()
        
        print("layout")
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let ctx = UIGraphicsGetCurrentContext()!
        drawGroups(in: ctx, with: rect)
    }
    
    fileprivate func drawBorder(in ctx: CGContext, with rect: CGRect) {
        borderColor.setStroke()
        
        ctx.setLineWidth(borderWidth)
        
        ctx.beginPath()
        ctx.move(to: CGPoint(x: rect.minX, y: rect.maxY + barOffset - borderWidth / 2))
        ctx.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY + barOffset - borderWidth / 2))
        ctx.closePath()
        
        ctx.strokePath()
    }
    
    fileprivate func drawGroups(in ctx: CGContext, with rect: CGRect) {
        guard let data = data
            else { return }
        
        let lowerBound: Value = minimumValue ?? data.minimumValue
        let upperBound: Value = maximumValue ?? data.maximumValue
        let range: ClosedRange = lowerBound...upperBound
        
        let groupRect: CGRect = barRect(for: rect)
        var groupX: CGFloat = groupSpacing
        
        /*var index: Int = 0*/
        
        var staafPath: StaafPath = StaafPath()
        
        for i in 0..<data.groupCount {
            let group = data.groups[i]
            
            let cacheItem: Cache = cache[i]
            let groupWidth: CGFloat = cacheItem.groupWidth
            
            ctx.saveGState()
            ctx.translateBy(x: groupX, y: 0)
            
            var barX: CGFloat = 0
            let barWidth: CGFloat = cacheItem.barWidth
            
            staafPath.groupIndex = i
            staafPath.relativeIndex = 0
            
            for j in 0..<group.valueCount {
                let value: Value = group.values[j]
                
                let barHeightMultiplier: CGFloat = CGFloat(value.normalize(to: range))
                let barHeight: CGFloat = groupRect.height * barHeightMultiplier
                let barOffset: CGFloat = groupRect.height - barHeight
                
                let barRect: CGRect = CGRect(x: barX, y: groupRect.origin.y + barOffset, width: barWidth, height: barHeight)
                colorStrategy.color(for: staafPath).setFill()
                ctx.fill(barRect)
                
                // Draw value label
                let textCacheItem: TextCacheItem = valueTextCache.items[staafPath.relativeIndex]
                let textLocation: CGPoint = CGPoint(x: barRect.midX - textCacheItem.size.width / 2, y: barRect.origin.y - textCacheItem.size.height - valueLabelOffset)
                textCacheItem.string.draw(at: textLocation, withAttributes: valueTextAttributes)
                
                barX += barWidth + barSpacing
                
                staafPath.relativeIndex += 1
                staafPath.absoluteIndex += 1
            }
            
            // Draw group label
            let textCacheItem: TextCacheItem = groupTextCache.items[i]
            let textRect: CGRect = CGRect(
                x: 0,
                y: rect.maxY - textCacheItem.size.height,
                width: groupWidth,
                height: textCacheItem.size.height
            )
            textCacheItem.string.draw(in: textRect, withAttributes: groupTextAttributes)
            
            ctx.restoreGState()
            
            groupX += groupWidth + groupSpacing
        }
        
        drawBorder(in: ctx, with: groupRect)
    }
    
    fileprivate func barRect(for bounds: CGRect) -> CGRect {
        let top: CGFloat = valueTextCache.maximumSize.height + valueLabelOffset
        let bottom: CGFloat = groupTextCache.maximumSize.height + groupLabelOffset + barOffset + borderWidth / 2
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(top, 0, bottom, 0))
    }
    
    // MARK: - Enums
    
    public enum Distribution {
        case equally
        case proportionally
        
        func distribute(_ barCount: Int, _ totalBarCount: Int, _ totalGroupCount: Int) -> CGFloat {
            switch self {
            case .equally:
                return CGFloat(1) / CGFloat(totalGroupCount)
            case .proportionally:
                return CGFloat(barCount) / CGFloat(totalBarCount)
            }
        }
    }
}

