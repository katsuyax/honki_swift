//
//  GameScene.swift
//  mogura
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import SpriteKit

class GameScene : SKScene {
  
  // もぐらのスプライトの配列
  var moguras: [SKSpriteNode] = []
  
  // もぐらの初期座標の配列
  let moguraPosition = [CGPoint(x: 100,y: 165), CGPoint(x: 275,y: 165), CGPoint(x: 100,y: 15), CGPoint(x: 275,y: 15)]
  
  // シーンが表示された時に呼ばれる
  override func didMoveToView(view: SKView) {
    
    // 背景画像のスプライトを配置する
    let background = SKSpriteNode(imageNamed: "background")
    background.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
    addChild(background)
    
    // 穴画像のスプライトを配置する
    let hole1 = SKSpriteNode(imageNamed: "hole")
    hole1.position = CGPoint(x: 100, y: 200)
    addChild(hole1)
    
    moguras.append(SKSpriteNode(imageNamed: "mogura"))
    moguras[0].position = moguraPosition[0]
    
    addChild(moguras[0])
    
    let hide1 = SKSpriteNode(imageNamed: "bg_hide")
    hide1.position = CGPoint(x: 100, y: 176)
    hide1.userInteractionEnabled = false;
    addChild(hide1)
    
    let hole2 = SKSpriteNode(imageNamed: "hole")
    hole2.position = CGPoint(x: 275, y: 200)
    addChild(hole2)
    
    moguras.append(SKSpriteNode(imageNamed: "mogura"))
    moguras[1].position = moguraPosition[1]
    addChild(moguras[1])
    
    let hide2 = SKSpriteNode(imageNamed: "bg_hide")
    hide2.position = CGPoint(x: 275, y: 176)
    hide2.userInteractionEnabled = false;
    addChild(hide2)
    
    let hole3 = SKSpriteNode(imageNamed: "hole")
    hole3.position = CGPoint(x: 100, y: 50)
    addChild(hole3)
    
    moguras.append(SKSpriteNode(imageNamed: "mogura"))
    moguras[2].position = moguraPosition[2]
    addChild(moguras[2])
    
    let hide3 = SKSpriteNode(imageNamed: "bg_hide")
    hide3.position = CGPoint(x: 100, y: 26)
    hide3.userInteractionEnabled = false;
    addChild(hide3)
    
    let hole4 = SKSpriteNode(imageNamed: "hole")
    hole4.position = CGPoint(x: 275, y: 50)
    addChild(hole4)
    
    moguras.append(SKSpriteNode(imageNamed: "mogura"))
    moguras[3].position = moguraPosition[3]
    addChild(moguras[3])
    
    let hide4 = SKSpriteNode(imageNamed: "bg_hide")
    hide4.position = CGPoint(x: 275, y: 26)
    hide4.userInteractionEnabled = false;
    addChild(hide4)
    
    // もぐらを動かす
    for index in 0...3 {
        moguras[index].position = moguraPosition[index]
        moguraAction(moguras[index])
    }
}
  
  // もぐらを上下させるアクションを設定する
  func moguraAction(sprite: SKSpriteNode) {
    
    // 1秒〜3秒 待機する
    let action1 = SKAction.waitForDuration(2.0, withRange: 2.0)
    
    // 現在の座標から 1 秒間かけて y 方向へ 100 移動させる
    let action2 = SKAction.moveByX(0, y: 100, duration: 1.0)
    
    // 0秒〜2秒 待機する
    let action3 = SKAction.waitForDuration(1.0, withRange: 2.0)
    
    // 現在の座標から 1 秒間かけて y 方向へ -100 移動させる
    let action4 = SKAction.moveByX(0, y: -100, duration: 1.0)
    
    // action1〜4 を連続的に実行する
    let actionSequence = SKAction.sequence([action1, action2, action3, action4])
    
    // actionSequence を繰り返し実行する
    let actionRepeat = SKAction.repeatActionForever(actionSequence)
    
    sprite.runAction(actionRepeat)
  }
    // タッチイベント
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            
            // タッチされた場所の座標を取得.
            let location = touch.locationInNode(self)
            
            // タッチされたノードを得る
            let touchNode = self.nodeAtPoint(location)
            
            for mog in moguras {
                if touchNode == mog {
                    touchedMogura(mog)
                }
            }
            
        }
    }
    
    // もぐらを叩いた時に呼ばれる
    func touchedMogura(sprite: SKSpriteNode) {
        
        // 叩かれたもぐらのアクションを止めて非表示にする
        sprite.removeAllActions()
        sprite.hidden = true
        
        // 回転しながら飛ばされるもぐら
        let hitMogura = SKSpriteNode(imageNamed: "mogura_hit")
        hitMogura.position = sprite.position
        
        let action1 = SKAction.rotateByAngle(CGFloat(M_PI) * 2, duration: 1)
        let action2 = SKAction.moveByX(0, y: 200, duration: 1)
        let action3 = SKAction.fadeOutWithDuration(1)
        let action4 = SKAction.removeFromParent()
        let action123 = SKAction.group([action1, action2,action3])
        let sequence = SKAction.sequence([action123, action4])
        
        
        addChild(hitMogura)
        
        hitMogura.runAction(sequence, completion: {
            [unowned self] in
            
            // もぐらの座標を初期値に戻して上下のアニメーションを再開させる
            if let index = self.moguras.indexOf(sprite) {
                sprite.position = self.moguraPosition[index]
            }
            sprite.hidden = false
            self.moguraAction(sprite)
            })
    }

}