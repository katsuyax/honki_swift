//
//  ViewController.swift
//  ImageProcessing
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var originalImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // UIImageView がタップされた時に呼ばれる。ImagePicker を表示させる
    @IBAction func handleTap(sender: UITapGestureRecognizer) {
      
    }
  
    // モノクロボタンが押された時に呼ばれる
    @IBAction func pushedMonochrome(sender: UIButton) {

    }
    
    // スライダーの値が変わった時に呼ばれる
    @IBAction func valueChanged(sender: UISlider) {

    }
    
    // 保存ボタンが押された時に呼ばれる
    @IBAction func save(sender: UIButton) {

    }
}

