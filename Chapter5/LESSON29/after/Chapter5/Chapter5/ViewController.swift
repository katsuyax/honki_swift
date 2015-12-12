//
//  ViewController.swift
//  Chapter5
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit

let calcHistoryKey: String = "calcHistoryUserdefaultKey"

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    // 数字入力の途中かどうかを示す。
    // trueの間、数字押下で順次桁を繰り上げる
    var usrInputting: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 数字ボタンを押した時に呼ばれる
    @IBAction func inputNumber(sender: UIButton) {
        var displayNum: String = "0"
        
        if !usrInputting {
            usrInputting = true
            displayNum = (sender.titleLabel?.text)!
        } else {
            displayNum = displayLabel.text!
            
            // 入力された文字を末尾に結合することで繰り上げを行う
            displayNum += (sender.titleLabel?.text)!
        }
        
        displayLabel.text = displayNum
    }
    
    // 計算結果を保持する変数
    var resultValue: Double {
        get {
            // displayLabel(UILabel) からテキストを取得して double 型に変換してから返す
            return NSNumberFormatter().numberFromString(displayLabel.text!)!.doubleValue
        }
        set {
            // displayLabel(UILabel) のテキストを計算結果の値で更新する
            displayLabel.text = "\(newValue)"
            
            // 数字入力中を解除する
            usrInputting = false
        }
    }
    
    // 被演算子
    var selectedOperand: String = ""
    
    // 四則演算ボタンを押した時に呼ばれる
    @IBAction func operate(sender: UIButton) {
        
        // 数字入力中の場合は計算を行うため ＝ ボタンを押した時のメソッドを呼び出す
        if usrInputting {
            enter()
        }
        
        // どの四則演算のボタンを押したか覚えておく (UILabel のテキストを使う)
        selectedOperand = (sender.titleLabel?.text)!
    }
    
    // 演算対象の数字
    var targetNum: Double? = nil
    
    // ＝ボタンを押した時に呼ばれる
    @IBAction func enter() {
        
        usrInputting = false
        
        if targetNum != nil && selectedOperand != "" {
            let resultNum: Double = resultValue
            
            switch selectedOperand {
            case "×":
                resultValue = targetNum! * resultNum
            case "÷":
                if resultNum == 0 { // 0除算を回避する
                    return
                }
                resultValue = targetNum! / resultNum
            case "+":
                resultValue = targetNum! + resultNum
            case "-":
                resultValue = targetNum! - resultNum
            default:
                break
            }
            
            saveHistory(resultValue)
        }
        
        selectedOperand = ""
        targetNum = resultValue
    }
    
    // ACボタンを押した時に呼ばれる
    @IBAction func clearAll(sender: UIButton) {
        targetNum = nil
        selectedOperand = ""
        resultValue = 0
    }
    
    // 計算結果の履歴保存用配列
    lazy var calcHistory: Array<Double> = []
    
    // UserDefaults に計算結果を保存する
    func saveHistory(result: Double) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        calcHistory.append(result)
        defaults.setObject(calcHistory, forKey:calcHistoryKey)
        
        defaults.synchronize()
    }
    
    // segue で画面遷移する時に呼ばれる
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        let historyViewController:HistoryViewController = segue.destinationViewController as! HistoryViewController
        historyViewController.calcHistory = calcHistory
    }
    
}

