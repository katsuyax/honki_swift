//
//  ViewController.swift
//  Photomap
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pinButton: UIButton!
    
    let locationManager = CLLocationManager()
    var lastLocation:CLLocationCoordinate2D?
    
    var imageArray: Array<UIImage> = Array<UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        // 100m 移動したら位置情報を更新する
        locationManager.distanceFilter = 100.0
        
        // 測位の精度を 100ｍ とする
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        // 位置情報サービスへの認証状態を取得する
        let status = CLLocationManager.authorizationStatus()
        
        if status == CLAuthorizationStatus.NotDetermined {
            // 未認証ならリクエストダイアログ出す
            locationManager.requestWhenInUseAuthorization();
        }
        
        // 位置情報の取得を開始させる
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pushedButton(sender: UIButton) {
        
        // カメラが使えるか確認する
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            
            // ImagePicker を表示する
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = UIImagePickerControllerSourceType.Camera
            cameraPicker.delegate = self
            self.presentViewController(cameraPicker, animated: true, completion: nil)
            
        }
    }
    
    func imagePickerController(imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            // 画像用の配列にいれる
            imageArray.append(pickedImage)
        }
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
        // 最後に取得した位置情報で CLLocationCoordinate2D を作成する
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lastLocation!.latitude, lastLocation!.longitude)
        
        // 最後に取得した位置情報を中心に地図を表示させる
        mapView.setCenterCoordinate(center, animated: true)
        
        // ピン（MKPointAnnotation）を作成する
        let pin: MKPointAnnotation = MKPointAnnotation()
        
        // 最後に取得した位置情報を設定する
        pin.coordinate = center
        
        // title と subtitle は Callout(吹き出し) に表示される
        pin.title = "\(mapView.annotations.count)"
        pin.subtitle = "\(lastLocation!.latitude), \(lastLocation!.longitude)"
        
        // 地図にピンを立てる
        mapView.addAnnotation(pin)
        
    }
    
    // ImagePicker でキャンセルされた場合に呼ばれる
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // 位置情報が更新された時に呼ばれる
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // 位置情報の配列から一番最後に取得した位置情報の緯度経度（coordinate）を取り出す
        let locations: NSArray = locations as NSArray
        let location: CLLocation = locations.lastObject as! CLLocation
        lastLocation = location.coordinate
        
        if let location = lastLocation {
            
            // 現在地から 5km 四方で表示させる
            let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(location, 5000, 5000)
            mapView.setRegion(region, animated: true)
            
            pinButton.enabled = true
        }
        
    }
    
    // ピンを表示する時に呼ばれる
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        
        let size: CGSize = CGSize(width: 42, height: 42)
        
        // 写真を描画する
        UIGraphicsBeginImageContext(size)
        imageArray[Int(annotation.title!!)!].drawInRect(CGRectMake(0, 0, size.width, size.height))
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        annotationView.annotation = annotation
        
        // 描画した写真を設定する
        annotationView.image = resizeImage
        
        // タップした時に Callout(吹き出し)が表示されるようにする
        annotationView.canShowCallout = true
        
        // Callout(吹き出し)にディスクロージャを表示する
        annotationView.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
        
        
        return annotationView
    }
    
    // Callout(吹き出し)をタップした時に呼ばれる
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        self.performSegueWithIdentifier("showImageViewSegue", sender: view)
        
        // Annotation を非選択にして Callout(吹き出し)を非表示にする
        mapView.deselectAnnotation(view.annotation, animated: true)
    }
    
    // 遷移先の ImageViewController に UIImage を渡す
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "showImageViewSegue" {
                let annotationView = sender as! MKAnnotationView
                
                let imageViewController = segue.destinationViewController as! ImageViewController
                imageViewController.image = imageArray[Int(annotationView.annotation!.title!!)!]
                
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status{
        case CLAuthorizationStatus.AuthorizedWhenInUse:
            // 位置情報の取得を開始させる
            locationManager.startUpdatingLocation()
        case CLAuthorizationStatus.AuthorizedAlways:
            // 位置情報の取得を開始させる
            locationManager.startUpdatingLocation()
        case CLAuthorizationStatus.Denied:
            print("Denied")
        case CLAuthorizationStatus.Restricted:
            print("Restricted")
        case CLAuthorizationStatus.NotDetermined:
            print("NotDetermined")
        }
    }
}

