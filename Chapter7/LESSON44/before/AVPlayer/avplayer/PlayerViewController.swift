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
  }
  
  // 音楽を再生する
  func playMusic(url: NSURL) {
    player = AVPlayer(URL: url)
    player?.play()
  }
  
  // 動画を再生する
  func playMovie(playerItem: AVPlayerItem) {
    player = AVPlayer(playerItem: playerItem)
    player?.play()
  }
}
