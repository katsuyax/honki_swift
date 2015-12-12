//
//  ViewController.swift
//  iAdSample
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit
import iAd

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // iAd(バナー) の表示
    canDisplayBannerAds = true
    
    // iAd(インタースティシャル：全画面)のマニュアル表示を設定
    interstitialPresentationPolicy = ADInterstitialPresentationPolicy.Manual

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func pushedButton(sender: UIButton) {
    
    // 全画面広告を表示する
    requestInterstitialAdPresentation()
  }
}

