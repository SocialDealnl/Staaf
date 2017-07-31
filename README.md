# Staaf

```swift
let staaf = Staaf(frame: CGRect(x: 0, y: 0, width: 320, height: 320))

let a = StaafDataGroup([21, 19], label: "Groep A")
let b = StaafDataGroup([7, 11], label: "Groep B")
let c = StaafDataGroup([15, 17], label: "Groep C")
let d = StaafDataGroup([13, 23], label: "Groep D")

let data = StaafData([a, b, c, d])

staaf.setup { (staaf: Staaf) -> Void in
    staaf.minimumValue = 0
    // staaf.maximumValue = 30
    
    staaf.colorStrategy = OddEvenColorStrategy(UIColor.lightGray, UIColor.blue)

    staaf.barSpacing = 8
    staaf.groupSpacing = 24

    staaf.borderWidth = 0.5
    staaf.borderColor = UIColor.gray
    staaf.valueFormatter = WholeNumberFormatter()
    // staaf.valueFormatter = DecimalFormatter(1)
    
    staaf.data = data
}
```
