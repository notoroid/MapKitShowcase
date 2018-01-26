//
//  ShowLocationViewController.swift
//  MapKitShowcase
//
//  Created by 能登 要 on 2018/01/26.
//  Copyright © 2018年 Kaname Noto. All rights reserved.
//

import UIKit
import MapKit

class ShowLocationViewController: UIViewController {
    public var coordinateForInitialized:CLLocationCoordinate2D? = nil
    @IBOutlet public weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // マップにユーザの現在地を表示
        if let coordinateForInitialized = coordinateForInitialized {
            let coordinate = coordinateForInitialized
            
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 1400, 1400)
            
            mapView.setRegion(region, animated: true)
        }
        
        mapView.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
