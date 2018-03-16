//
//  OverlaysViewController.swift
//  MapKitShowcase
//
//  Created by 能登 要 on 2018/03/16.
//  Copyright © 2018年 Kaname Noto. All rights reserved.
//

import UIKit
import MapKit

class OverlaysViewController: UIViewController {

    enum OverlayType : Int {
        case circle = 0
        case line = 1
    }
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    
    private let viewModel = ShowcaseViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.toolbarItems = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),UIBarButtonItem(customView: segmentedControl),UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)]
        self.navigationController?.isToolbarHidden = false
        
        
        let region = MKCoordinateRegionMakeWithDistance(viewModel.centerCordinate, 1400, 1400)
        
        mapView.setRegion(region, animated: true)
        
        let ca = viewModel.companyAnnotation
        ca.coordinate = viewModel.companyCoordinate
        
        var annotations = [MKPointAnnotation]()
        annotations.append(ca)
        viewModel.shopAnnotations.forEach { (sanno) in
            annotations.append(sanno)
        }
        
        // アノテーションのセットアプ
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotations(annotations)
        self.mapView.showAnnotations(self.mapView.annotations, animated: false)
        
        if let ot = OverlayType(rawValue:segmentedControl.selectedSegmentIndex) {
            configureOverlay(ot)
        }
    }
    
    
    @IBAction func onChangeOverlayType(_ sender: UISegmentedControl) {
        if let ot = OverlayType(rawValue:segmentedControl.selectedSegmentIndex) {
            configureOverlay(ot)
        }
    }
    
    private func configureOverlay(_ overlayType:OverlayType) {
        self.mapView.removeOverlays(self.mapView.overlays)

        switch overlayType {
        case .circle:
            let circle = CompanyCircle(center: viewModel.companyCoordinate, radius: 5)
            self.mapView.add(circle)
        case .line:
            // 会社位置と店舗位置をつなぐ線を追加する
            var coordinates = [CLLocationCoordinate2D]()
            coordinates.append(viewModel.companyCoordinate)
            
            if let ca = viewModel.shopAnnotations.first {
                coordinates.append(ca.coordinate)
            }
            let line = MKPolyline(coordinates: &coordinates, count: 2)
            self.mapView.add(line)
        }
    }
    

}

extension OverlaysViewController  : MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circle = overlay as? CompanyCircle {
            let renderer:MKCircleRenderer = MKCircleRenderer(circle: circle)
            renderer.strokeColor = UIColor.red.withAlphaComponent(0.5)
            renderer.lineWidth = 1
            renderer.fillColor = UIColor.red.withAlphaComponent(0.3)
            
            return renderer
        }
     
        let renderer:MKPolylineRenderer = MKPolylineRenderer(overlay:overlay)
        
        renderer.strokeColor = UIColor(red: 0.175, green: 0.493, blue: 0.145, alpha: 1)
        renderer.lineWidth = 2
        
        return renderer
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        if let canno = annotation as? CompanyAnnotation {
            var annov = mapView.dequeueReusableAnnotationView(withIdentifier: canno.resouceId() )
            if annov == nil {
                annov = MKAnnotationView(annotation: canno, reuseIdentifier: canno.resouceId())
                annov?.image = UIImage(named:"pinCompany")
            } else {
                annov?.annotation = canno
            }
            
            return annov
        }

        return nil
    }
    
}
