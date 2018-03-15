//
//  CustomUserInterfaceViewController.swift
//  MapKitShowcase
//
//  Created by 能登 要 on 2018/03/15.
//  Copyright © 2018年 Kaname Noto. All rights reserved.
//

import UIKit
import MapKit

class CustomUserInterfaceViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet var mapZoomGesture: UIPanGestureRecognizer!
    @IBOutlet weak var zoomSliderBackgroundView: UIView!
    @IBOutlet weak var zoomSliderView: UIView!
    @IBOutlet weak var zoomSliderCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var zoomSliderBackgroundHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var zoomSliderHeightConstraint: NSLayoutConstraint!
    private var beginaltitude:CLLocationDistance = CLLocationDistance(0)
    
    private let viewModel = ShowcaseViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let region = MKCoordinateRegionMakeWithDistance(viewModel.centerCordinate, viewModel.defaultRadius, viewModel.defaultRadius)
        
        mapView.setRegion(region, animated: true)

    }

    @IBAction func onMapZoom(_ sender: UIPanGestureRecognizer) {
        //移動量を取得する。
        let move:CGPoint = sender.translation(in: view)
        
        if sender.state == .began {
            beginaltitude = mapView.camera.altitude
            
        }else if sender.state != .ended {
            let sliderRange = (zoomSliderBackgroundHeightConstraint.constant - zoomSliderHeightConstraint.constant) * 0.5
            zoomSliderCenterYConstraint.constant += move.y
            zoomSliderCenterYConstraint.constant = max(zoomSliderCenterYConstraint.constant,-sliderRange)
            zoomSliderCenterYConstraint.constant = min(zoomSliderCenterYConstraint.constant,sliderRange)
            self.view.layoutIfNeeded()
            
            let ratio = Double(zoomSliderCenterYConstraint.constant / sliderRange)
            
            if let newCamera = mapView.camera.copy() as? MKMapCamera {
                newCamera.altitude = beginaltitude + beginaltitude * ratio
                mapView.camera = newCamera
            }
        }
        
        if sender.state == .ended  {
            zoomSliderCenterYConstraint.constant = 0
            
            //アニメーションさせる。
            UIView.animate(withDuration: 0.25, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
        //移動量をリセットする。
        sender.setTranslation(CGPoint.zero, in: view)
    }

}
