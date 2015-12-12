//
//  ViewController.swift
//  Sound
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ボタンがタップされた時に呼ばれる
    @IBAction func pushedButton(sender: UIButton) {
        switch sender.tag {
        case 0:
            playSound()
        case 1:
            playLoop()
        default:
            break
        }
    }
    
    // 音声ファイルを再生する
    func playSound() {
        // 再生する音声ファイルのパスを取得する
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sample1", ofType: "mp3")!)
        
        // 音声ファイルを再生するプレイヤーを作成する
        audioPlayer = try! AVAudioPlayer(contentsOfURL: audioPath, fileTypeHint: nil)
        
        // 再生する
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }

    // 音声ファイルをループ再生する
    func playLoop() {
        // 再生する音声ファイルのパスを取得する
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sample2", ofType: "mp3")!)
        
        // 音声ファイルを再生するプレイヤーを作成する
        audioPlayer = try! AVAudioPlayer(contentsOfURL: audioPath, fileTypeHint: nil)
        
        // 繰り返し回数を3回に設定
        audioPlayer.numberOfLoops = 3
        
        // 再生する
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
}

