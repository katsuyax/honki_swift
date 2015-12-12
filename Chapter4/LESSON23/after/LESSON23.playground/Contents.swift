import UIKit

var label = UILabel(frame: CGRectMake(0, 0, 100, 30))

label.text = "Swift"
label.textAlignment = NSTextAlignment.Center
label.backgroundColor = UIColor(red: 0.5, green: 1.0, blue: 1.0, alpha: 1.0)
label.textColor = UIColor.whiteColor()

var textField = UITextField(frame: CGRectMake(0, 0, 100, 30))
var textView = UITextView(frame: CGRectMake(0, 0, 150, 100))

textField.text = "UITextFiled"
textView.text = "1行目\n2行目\n3行目"

