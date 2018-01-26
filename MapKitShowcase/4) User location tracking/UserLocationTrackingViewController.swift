//
//  UserLocationTrakingViewController.swift
//  MapKitShowcase
//
//  Created by 能登 要 on 2018/01/26.
//  Copyright © 2018年 Kaname Noto. All rights reserved.
//

import UIKit
import MapKit

class UserLocationTrackingViewController: UIViewController {
    public var coordinateForInitialized:CLLocationCoordinate2D? = nil

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // マップにユーザの現在地を表示
        if let coordinateForInitialized = coordinateForInitialized {
            let coordinate = coordinateForInitialized
            
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 100, 100)
            
            mapView.setRegion(region, animated: true)
        }
        
        let trackingButton = MKUserTrackingButton(mapView: mapView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: trackingButton)
    }
}


