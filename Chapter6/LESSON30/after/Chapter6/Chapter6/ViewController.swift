//
//  ViewController.swift
//  Chapter6
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var tableView: UITableView!
    
    var dataArray:[Int] = []
  
    // ボタンが押された時にデータを追加する
    @IBAction func add(sender: UIBarButtonItem) {
        dataArray.append(dataArray.count)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITableViewDataSource プロトコルのメソッド
    // TableView の各セクションのセルの数を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    // 各セルの内容を返す
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        // Cellに値を設定する.
        cell.textLabel?.text = "\(dataArray[indexPath.row])"
        cell.detailTextLabel?.text = "Subtitle \(dataArray[indexPath.row])"
        
        return cell
    }

    // MARK: UITableViewDataSource プロトコルのメソッド
    // Delete ボタンが押された時の処理を行う
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            dataArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation:
            UITableViewRowAnimation.Fade)
        }
    }
    
    // セルが削除が可能なことを伝える
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete;
    }
}

