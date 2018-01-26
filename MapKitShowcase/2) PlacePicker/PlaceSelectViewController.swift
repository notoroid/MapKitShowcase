//
//  PlaceSelectViewController.swift
//  MobileLocationSystemSwift
//
//  Created by 能登 要 on 2017/11/09.
//  Copyright © 2017年 Kaname Noto. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

fileprivate let ZOOM_LEVEL = Double(1400)

class PlaceSelectViewController: UIViewController {
    public var coordinateForInitialized:CLLocationCoordinate2D? = nil
    public weak var delegate:PlaceSelectViewControllerDelegate?
    public var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    private let locationManager = CLLocationManager()
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancel(_:)))
     
        addButton.isEnabled = false
        
        // マップにユーザの現在地を表示
        if let coordinateForInitialized = coordinateForInitialized {
            let coordinate = coordinateForInitialized
            
            let region = MKCoordinateRegionMakeWithDistance(coordinate, ZOOM_LEVEL, ZOOM_LEVEL)
            
            mapView.setRegion(region, animated: true)
            
            // 初期化された位置にピンを立てる
            self.setAnnotation(coordinate, mapMove: false, animated: true)
        }else{
            locationManager.startUpdatingLocation()
            locationManager.delegate = self
        }
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        mapView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func handleLongPressGesture(_ gesture:UILongPressGestureRecognizer){
        if gesture.state == .began { // 長押し検出開始時のみ動作
            let touchedPoint = gesture.location(in: mapView)
            let touchCoordinate = mapView.convert(touchedPoint, toCoordinateFrom: mapView)
            setAnnotation(touchCoordinate, mapMove: false, animated: false)
        }
    }

    private func setAnnotation( _ point:CLLocationCoordinate2D, mapMove:Bool,animated:Bool ){
            // ピンを全て削除
            mapView.removeAnnotations(mapView.annotations)
        
            // 新しいピンを作成
            let anno:MKPointAnnotation = MKPointAnnotation()
            anno.coordinate = point
        
            // ピンを追加
            mapView.addAnnotation(anno)
        
            // ピンの周りに円を表示
            let circle = MKCircle(center: point, radius: 500)
            mapView.removeOverlays(mapView.overlays)
        
            mapView.addOverlays([circle])
        
            // ボタンを有効化
            addButton.isEnabled = true
    }

    @IBAction func onAddPlace(_ sender: UIButton) {
        let annotation = mapView.annotations[0]
        coordinate = annotation.coordinate
        delegate?.placeSelectViewController(didAddPlace: self)
    }
    
    @objc func onCancel(_ sender:UIBarButtonItem){
        delegate?.placeSelectViewController(didCancel: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        locationManager.stopUpdatingLocation()
    }
    
}

protocol PlaceSelectViewControllerDelegate : NSObjectProtocol {
    func placeSelectViewController(didAddPlace placeSelectViewController:PlaceSelectViewController)
    func placeSelectViewController(didCancel placeSelectViewController:PlaceSelectViewController)
}

extension PlaceSelectViewController : MKMapViewDelegate
{
    
}

extension PlaceSelectViewController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
}

