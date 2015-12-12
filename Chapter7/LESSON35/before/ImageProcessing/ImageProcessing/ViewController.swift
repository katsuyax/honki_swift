//
//  ViewController.swift
//  ImageProcessing
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var originalImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UIImageView がタップされた時に呼ばれる。ImagePicker を表示させる
    @IBAction func handleTap(sender: UITapGestureRecognizer) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
        {
            let ipc:UIImagePickerController = UIImagePickerController();
            ipc.delegate = self
            ipc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(ipc, animated:true, completion:nil)
        }
    }
    
    // ImagePicker で画像が選択された時に呼ばれる
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if info[UIImagePickerControllerOriginalImage] != nil {
            
            // 選択した画像を UIImageView に設定する
            imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            
            // 加工用にメンバ変数に保持しておく
            originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        
        // ImagePicker を閉じる
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // モノクロボタンが押された時に呼ばれる
    @IBAction func pushedMonochrome(sender: UIButton) {

    }
    
    // スライダーの値が変わった時に呼ばれる
    @IBAction func valueChanged(sender: UISlider) {

    }
    
    // 保存ボタンが押された時に呼ばれる
    @IBAction func save(sender: UIButton) {

    }
}

