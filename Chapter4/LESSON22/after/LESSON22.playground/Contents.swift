import UIKit

var button = UIButton(frame: CGRectMake(0, 0, 100, 50))

button.backgroundColor = UIColor.blueColor()
button.setTitle("Button", forState: UIControlState.Normal)

button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)

var slider = UISlider(frame: CGRectMake(0, 0, 100, 30))
slider.minimumValue = 0.0
slider.maximumValue = 100.0
slider.value = 75.0