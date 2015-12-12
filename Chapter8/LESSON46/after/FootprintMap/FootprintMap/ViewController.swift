//
//  ViewController.swift
//  FootprintMap
//
//  Copyright © 2015年 shoeisha. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pinButton: UIButton!
    
    let locationManager = CLLocationManager()
    var lastLocation:CLLocationCoordinate2D?
    
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
        
        // 最後に取得した位置情報で CLLocationCoordinate2D を作成する
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lastLocation!.latitude, lastLocation!.longitude)
        
        // 地図のセンターに設定する
        mapView.setCenterCoordinate(center, animated: true)
        
        // ピン（MKPointAnnotation）を作成する
        let pin: MKPointAnnotation = MKPointAnnotation()
        
        // 最後に取得した位置情報を設定する
        pin.coordinate = center
        
        // 地図にピンを立てる
        mapView.addAnnotation(pin)
    }
    
    // 位置情報が更新された時に呼ばれる
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // 位置情報の配列から一番最後に取得した位置情報の緯度経度（coordinate）を取り出す
        let locations: NSArray = locations as NSArray
        let location: CLLocation = locations.lastObject as! CLLocation
        lastLocation = location.coordinate
        
        if let location = lastLocation {
            
            // 最後に取得した位置情報で CLLocationCoordinate2D を作成する
            let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lastLocation!.latitude, lastLocation!.longitude)
            
            // 地図のセンターに設定する
            mapView.setCenterCoordinate(center, animated: true)
            
            // 現在地から 5km 四方で表示させる
            let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(location, 5000, 5000)
            mapView.setRegion(region, animated: true)
            
            pinButton.enabled = true
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

