//
//  ViewController.swift
//  Accelerometer
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    
    let motionManager = CMMotionManager()
    
    var lastAccelerometer: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 加速度センサの更新間隔を 0.1 秒とする
        motionManager.accelerometerUpdateInterval = 0.1
        
        // accelerometerUpdateIntervalで設定した更新間隔ごとにハンドラが呼び出される
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) { (accelerometerData, error) -> Void in
            let x = accelerometerData!.acceleration.x
            let y = accelerometerData!.acceleration.y
            let z = accelerometerData!.acceleration.z
            
            // 各方向ごとの値を UILabel に表示する
            self.xLabel.text = "x: \(x)"
            self.yLabel.text = "y: \(y)"
            self.zLabel.text = "z: \(z)"
            
            // 速度によって画像を変更する
            let accelerometer = abs(x + y + z - self.lastAccelerometer)
            
            switch accelerometer {
            case 0.0 ..< 0.5:
                self.imageView.image = UIImage(named:"meter_0")
            case 0.5 ..< 1.0:
                self.imageView.image = UIImage(named:"meter_1")
            case 1.0 ..< 1.5:
                self.imageView.image = UIImage(named:"meter_2")
            case 1.5 ..< 2.0:
                self.imageView.image = UIImage(named:"meter_3")
            case 2.0 ..< 2.5:
                self.imageView.image = UIImage(named:"meter_4")
            default:
                self.imageView.image = UIImage(named:"meter_5")
            }
            
            // 値を覚える
            self.lastAccelerometer = x + y + z
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

