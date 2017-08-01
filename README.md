# Staaf

Low-Effort Bar Graph

### Demo

![Demo](https://github.com/robhendriks/Staaf/raw/master/Screenshots/1.gif)

### Usage

```swift
let staafData = StaafData([
    StaafDataGroup([1, 2, 3], label: "A"),
    StaafDataGroup([2, 4, 6], label: "B"),
    StaafDataGroup([3, 6, 9], label: "C")
])
```

```swift
let staaf = Staaf(frame: CGRect(x: 0, y: 0, width: 320, height: 320))

staaf.setup {
    // Configure y-axis
    $0.minimumValue = 0
    $0.maximumValue = 100

    // Configure layout
    $0.barSpacing = 5
    $0.barOffset = 5
    $0.groupDistribution = .proportionally
    $0.groupSpacing = 15

    // Configure group labels
    $0.groupLabelFont = UIFont.systemFont(ofSize: 9)
    $0.groupLabelColor = UIColor.gray
    $0.groupLabelOffset = 5

    // Configure value labels
    $0.valueLabelFont = UIFont.systemFont(ofSize: 7)
    $0.valueLabelColor = UIColor.lightGray
    $0.valueLabelOffset = 3

    // Configure border
    $0.borderWidth = 0.5
    $0.borderColor = UIColor.lightGray

    // Configure formatting
    $0.valueFormatter = WholeNumberFormatter()

    // Configure color
    $0.colorStrategy = SingleColorStrategy()

    // Set data
    $0.data = staafData
}
```

