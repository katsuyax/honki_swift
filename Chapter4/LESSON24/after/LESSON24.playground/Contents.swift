import UIKit

let image = UIImage(named: "image")

let url = NSURL(string: "http://www.shoeisha.co.jp/assets/img/logo/logo2.png")
let imageData :NSData = NSData(contentsOfURL: url!)!
let image2 = UIImage(data:imageData);

let imageView = UIImageView(frame: CGRectMake(0,0,100,100))
imageView.image = image
