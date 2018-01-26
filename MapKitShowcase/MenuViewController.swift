//
//  MenuViewController.swift
//  MapKitShowcase
//
//  Created by 能登 要 on 2018/01/26.
//  Copyright © 2018年 Kaname Noto. All rights reserved.
//

import UIKit
import CoreLocation

class MenuViewController: UITableViewController {
    
    public var placePickerCoordinate:CLLocationCoordinate2D? = nil
    private let locationManager = CLLocationManager() // Core Location
    @IBOutlet private weak var placePickerLabel: UILabel!
    private var initialized = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updatePlacePickerInformation()
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if initialized != true {
            initialized = true
            performSegue(withIdentifier: "waitingSegue", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "showLocationSegue":
            guard let vc = segue.destination as? ShowLocationViewController else { return }
            vc.coordinateForInitialized = placePickerCoordinate
            vc.mapView.showsUserLocation = true
        case "placePickerSegue":
            guard let nc = segue.destination as? UINavigationController else { return }
            guard let psvc = nc.topViewController as? PlaceSelectViewController else { return }
            
            psvc.delegate = self
            psvc.coordinateForInitialized = placePickerCoordinate
        case "showConpassAndScaleSegue":
            guard let vc = segue.destination as? ConpassAndScaleViewController else { return }
            vc.coordinateForInitialized = placePickerCoordinate
        case "showUserLocationTrackingSegue":
            guard let vc = segue.destination as? UserLocationTrackingViewController else { return }
            vc.coordinateForInitialized = placePickerCoordinate
        case "showAnnotationSegue":
            break
        default:
            break
        }
    }
    
    private func updatePlacePickerInformation() {
        if let placePickerCoordinate = placePickerCoordinate {
            placePickerLabel.text = "緯度\(placePickerCoordinate.longitude)\n経度\(placePickerCoordinate.latitude)"
        }else{
            placePickerLabel.text = ""
        }
    }
    
}

extension MenuViewController : CLLocationManagerDelegate
{
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let newLocation = locations.last {
            self.dismiss(animated: true)
            
            placePickerCoordinate = newLocation.coordinate
            updatePlacePickerInformation()
            
            locationManager.stopUpdatingLocation()
        }
    }
    
}

extension MenuViewController : PlaceSelectViewControllerDelegate
{
    func placeSelectViewController(didCancel placeSelectViewController: PlaceSelectViewController) {
        
        dismiss(animated: true)
    }
    
    func placeSelectViewController(didAddPlace placeSelectViewController: PlaceSelectViewController) {
        
        placePickerCoordinate = placeSelectViewController.coordinate
        updatePlacePickerInformation()
        
        dismiss(animated: true)
    }
}

