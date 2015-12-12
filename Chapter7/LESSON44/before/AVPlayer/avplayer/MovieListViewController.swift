//
//  MovieListViewController.swift
//  AVPlayer
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit
import Photos

class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
  
  @IBOutlet var tableView: UITableView!
  
  var videos = Array<PHAsset>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    videos = getVideos()
    tableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func getVideos() -> Array<PHAsset> {
    var array = Array<PHAsset>()
    
    // Video を指定してアセットを取得する
    let assets: PHFetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Video, options: nil)
    
    // アセットを順番に配列に入れる
    assets.enumerateObjectsUsingBlock { (asset, index, stop) -> Void in
      array.append(asset as! PHAsset)
    }
    
    return array
  }
  
  // MARK: UITableViewDataSource プロトコルのメソッド
  // TableView の各セクションのセルの数を返す
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return videos.count
  }
  
  // 各セルの内容を返す
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    // 再利用可能な cell を得る
    let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
    
    // Cellに値を設定する
    cell.textLabel?.text = videos[indexPath.row].creationDate?.description
    cell.detailTextLabel?.text = "\(videos[indexPath.row].duration.description) sec"
    
    return cell
  }
  
  // 各セルを選択した時に実行される
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("cellSegue",sender: nil)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  // PlayerViewController に動画ファイル一覧を渡して再生を開始させる
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let playerViewController = segue.destinationViewController as? PlayerViewController {
      let manager: PHImageManager = PHImageManager()
      manager.requestPlayerItemForVideo(videos[(tableView.indexPathForSelectedRow?.row)!], options: nil, resultHandler: { (item, info) -> Void in
        playerViewController.playMovie(item!)
        })
    }
  }
}

