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
        case 2:
            reverb()
        case 3:
            delay()
        case 4:
            distortion()
        case 5:
            timePitch()
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
    
    var audioPlayerNode: AVAudioPlayerNode!
    var audioEngine: AVAudioEngine!
    
    // リバーブをかけて再生する
    func reverb() {
        
        // リバーブを準備する
        let reverbEffect = AVAudioUnitReverb()
        reverbEffect.loadFactoryPreset(AVAudioUnitReverbPreset.LargeHall2)
        reverbEffect.wetDryMix = 50
        
        // AVAudioEngine と AVAudioPlayerNode を生成する
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        
        // AudioFile を準備する
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sample2", ofType: "mp3")!)
        let audioFile = try! AVAudioFile(forReading: audioPath)
        
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(reverbEffect)
        
        audioEngine.connect(audioPlayerNode, to: reverbEffect, format: audioFile.processingFormat)
        audioEngine.connect(reverbEffect, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)
        
        audioEngine.prepare()
        try! audioEngine.start()
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil) { () -> Void in
            print("complete")
        }
        audioPlayerNode.play()
    }
    
    // ディレイをかけて再生する
    func delay() {
        
        // ディレイを準備する
        let delayEffect = AVAudioUnitDelay()
        delayEffect.delayTime = 0.5
        delayEffect.feedback = 50
        delayEffect.wetDryMix = 50
        
        // AVAudioEngine と AVAudioPlayerNode を生成する
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        
        // AudioFile を準備する
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sample1", ofType: "mp3")!)
        let audioFile = try! AVAudioFile(forReading: audioPath)
        
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(delayEffect)
        
        audioEngine.connect(audioPlayerNode, to: delayEffect, format: audioFile.processingFormat)
        audioEngine.connect(delayEffect, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)
        
        audioEngine.prepare()
        try! audioEngine.start()
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil) { () -> Void in
            print("complete")
        }
        audioPlayerNode.play()
    }
    
    // ディストーションをかけて再生する
    func distortion() {
        // ディストーションを準備する
        let distortionEffect = AVAudioUnitDistortion()
        distortionEffect.loadFactoryPreset(AVAudioUnitDistortionPreset.MultiBrokenSpeaker)
        distortionEffect.wetDryMix = 50
        
        // AVAudioEngine と AVAudioPlayerNode を生成する
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sample2", ofType: "mp3")!)
        let audioFile = try! AVAudioFile(forReading: audioPath)
        
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(distortionEffect)
        
        audioEngine.connect(audioPlayerNode, to: distortionEffect, format: audioFile.processingFormat)
        audioEngine.connect(distortionEffect, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)
        
        audioEngine.prepare()
        try! audioEngine.start()
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil) { () -> Void in
            print("complete")
        }
        audioPlayerNode.play()
    }
    
    // ピッチと再生時間を変えて再生する
    func timePitch() {
        
        // ピッチと再生時間を変更する
        let timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = 1000
        timePitch.rate = 0.5
        
        // AVAudioEngine と AVAudioPlayerNode を生成する
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        
        // AudioFile を準備する
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sample2", ofType: "mp3")!)
        let audioFile = try! AVAudioFile(forReading: audioPath)
        
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(timePitch)
        
        audioEngine.connect(audioPlayerNode, to: timePitch, format: audioFile.processingFormat)
        audioEngine.connect(timePitch, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)
        
        audioEngine.prepare()
        try! audioEngine.start()
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil) { () -> Void in
            print("complete")
        }
        audioPlayerNode.play()
    }
}

