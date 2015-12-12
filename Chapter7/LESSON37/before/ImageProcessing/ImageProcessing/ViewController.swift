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
        guard let image = imageView.image else {
            return
        }
        
        let monochroImage = monochromeImage(image)
        
        imageView.image = monochroImage
        originalImage = monochroImage
    }
    
    // 引数の UIImage の画像をモノクロ化した UIImage を返す
    func monochromeImage(srcImage: UIImage) -> UIImage {
        
        // UIImage から CIImage を作成する
        let ciImage:CIImage = CIImage(image:srcImage)!;
        
        // コンテキストを作成する
        let ciContext:CIContext = CIContext(options: nil)
        
        // フィルターを作成する
        let ciFilter:CIFilter = CIFilter(name: "CIMinimumComponent")!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        
        // フィルターを通した画像を生成する
        let cgimg:CGImageRef = ciContext.createCGImage(ciFilter.outputImage!, fromRect:ciFilter.outputImage!.extent)
        
        // CGImageRef から UIImage を生成して返す
        return UIImage(CGImage: cgimg, scale: 1.0, orientation:UIImageOrientation.Up)
    }

    // スライダーの値が変わった時に呼ばれる
    @IBAction func valueChanged(sender: UISlider) {
        guard let image = originalImage else {
            return
        }
        
        imageView.image =  brightnessImage(image, brightness: CGFloat(sender.value))
    }
    
    // 引数の UIImage の画像の輝度を調整した UIImage を返す
    func brightnessImage(srcImage: UIImage, brightness: CGFloat) -> UIImage {
        
        // UIImage から CIImage を作成する
        let ciImage:CIImage = CIImage(image:srcImage)!;
        
        // コンテキストを作成する
        let ciContext:CIContext = CIContext(options: nil)
        
        // フィルターを作成する
        let ciFilter:CIFilter = CIFilter(name: "CIColorControls")!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(brightness, forKey: kCIInputBrightnessKey)
        
        // フィルターを通した画像を生成する
        let cgimg:CGImageRef = ciContext.createCGImage(ciFilter.outputImage!, fromRect:ciFilter.outputImage!.extent)
        
        // CGImageRef から UIImage を生成して返す
        return UIImage(CGImage: cgimg, scale: 1.0, orientation:UIImageOrientation.Up)
    }
    
    // 保存ボタンが押された時に呼ばれる
    @IBAction func save(sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    
    // カメラロールへ保存が完了した時に呼ばれる
    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
        
    }
   
}

