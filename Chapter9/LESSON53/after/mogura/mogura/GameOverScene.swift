//
//  GameOverScene.swift
//  mogura
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import SpriteKit

class GameOverScene : SKScene {
    
    var button: SKSpriteNode?
    var score: Int = 0
    
    // シーンが表示された時に呼ばれる
    override func didMoveToView(view: SKView) {
        
        // 背景画像のスプライトを配置する
        let background = SKSpriteNode(imageNamed: "bg_result")
        background.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        addChild(background)
        
        
        // 得点のラベルを配置する
        let scoreLabel1 = SKLabelNode (fontNamed: "ArialRoundedMYBold")
        scoreLabel1.fontSize = 40
        scoreLabel1.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        scoreLabel1.text = "SCORE"
        scoreLabel1.fontColor = UIColor.blackColor()
        scoreLabel1.position = CGPoint(x: self.size.width * 0.5, y: 470)
        addChild(scoreLabel1)
        
        let scoreLabel2 = SKLabelNode (fontNamed: "ArialRoundedMYBold")
        scoreLabel2.fontSize = 80
        scoreLabel2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        scoreLabel2.text = "\(score)"
        scoreLabel2.fontColor = UIColor.redColor()
        scoreLabel2.position = CGPoint(x: self.size.width * 0.5, y: 380)
        addChild(scoreLabel2)
        
        // もう一度遊ぶボタンを配置する
        let button = SKSpriteNode(imageNamed: "btn_replay")
        button.position = CGPoint(x: self.size.width * 0.5, y: 200)
        addChild(button)
        self.button = button
    }
    
    // タッチイベント
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            
            // タッチされた場所の座標を取得.
            let location = touch.locationInNode(self)
            
            // タッチされたノードを得る
            let touchNode = self.nodeAtPoint(location)
            
            if touchNode == button {
                let gameScene = GameScene(size: size)
                let skView = view as SKView!
                gameScene.scaleMode = SKSceneScaleMode.AspectFit
                skView.presentScene(gameScene)
            }
        }
    }
}