//
//  MusicListViewController.swift
//  AVPlayer
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit
import MediaPlayer

class MusicListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet var tableView: UITableView!
    
    // 曲情報
    var songs = Array<MPMediaItem>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songs = getSongs()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // iPhone 内から曲情報を取得する
    func getSongs() -> Array<MPMediaItem> {
        
        var array = Array<MPMediaItem>()
        
        // アルバム情報を取得する
        let albumsQuery: MPMediaQuery = MPMediaQuery.albumsQuery()
        let albumItems: [MPMediaItemCollection] = albumsQuery.collections!
        
        // アルバム情報から曲情報を取得する
        for album in albumItems {
            let albumItems: [MPMediaItem] = album.items
            for song in albumItems {
                array.append( song )
            }
        }
        
        return array
    }
    
    // MARK: UITableViewDataSource プロトコルのメソッド
    // TableView の各セクションのセルの数を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    // 各セルの内容を返す
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        // Cellに値を設定する.
        cell.textLabel?.text = songs[indexPath.row].title
        cell.detailTextLabel?.text = songs[indexPath.row].albumTitle
        
        return cell
    }
    
    // 各セルを選択した時に実行される
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("cellSegue",sender: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // PlayerViewController にURLを渡して再生を開始させる
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let playerViewController = segue.destinationViewController as? PlayerViewController {
            let url = songs[(tableView.indexPathForSelectedRow?.row)!].valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL
            playerViewController.playMusic(url!)
        }
    }
}

