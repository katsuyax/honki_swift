//
//  ViewController.swift
//  SpriteKitSample
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // View を取り出してデバッグ用表示の設定を行う
        let skView = self.view as! SKView
        
        // FPS の表示
        skView.showsFPS = true
        
        // ノード数の表示
        skView.showsNodeCount = true
        
        // SKScene を生成する
        let scene = SKScene()
        
        // SKScene の size を SKView と同じサイズにする
        scene.size = skView.frame.size
        
        // SKView と SKScene の size が異なる場合は AspectFit (アスペクト比を保ったまま全てを表示する。場合によっては隙間ができる)
        scene.scaleMode = SKSceneScaleMode.AspectFit
        
        // SKView に SKScene を設定して表示させる
        skView.presentScene(scene)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ステータスバーを非表示にする
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

