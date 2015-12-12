//
//  PlayerViewController.swift
//  AVPlayer
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PlayerViewController: AVPlayerViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        player?.pause()
        UIApplication.sharedApplication().endReceivingRemoteControlEvents()
        try! AVAudioSession.sharedInstance().setActive(false)
    }
    
    // 音楽を再生する
    func playMusic(url: NSURL) {
        player = AVPlayer(URL: url)
        
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try! AVAudioSession.sharedInstance().setActive(true)
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        
        player?.play()
    }
    
    // 動画を再生する
    func playMovie(playerItem: AVPlayerItem) {
        player = AVPlayer(playerItem: playerItem)
        
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try! AVAudioSession.sharedInstance().setActive(true)
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        
        player?.play()
    }
}
