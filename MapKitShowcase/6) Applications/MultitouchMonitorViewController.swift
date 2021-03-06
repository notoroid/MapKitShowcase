//
//  MultitouchMonitorViewController.swift
//  MapKitShowcase
//
//  Created by 能登 要 on 2018/02/01.
//  Copyright © 2018年 Kaname Noto. All rights reserved.
//

import UIKit
import MapKit

class MultitouchMonitorViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet var pinchGestureRecognizer: UIPinchGestureRecognizer!
    @IBOutlet var rotationGestureRecognizer: UIRotationGestureRecognizer!
    @IBOutlet var panGestureRecongnizer: UIPanGestureRecognizer!
    @IBOutlet weak var enterMapViewGestureLabel: UILabel!
    
    private let viewModel = ShowcaseViewModel()
    
    var enterMapViewGesture = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let region = MKCoordinateRegionMakeWithDistance(viewModel.centerCordinate, viewModel.defaultRadius, viewModel.defaultRadius)
        
        mapView.setRegion(region, animated: true)
        
        let ca = viewModel.companyAnnotation
        ca.coordinate = CLLocationCoordinate2DMake(43.064506, 141.362703)
        
        
        var annotations = [MKPointAnnotation]()
        annotations.append(ca)
        viewModel.shopAnnotations.forEach { (sanno) in
            annotations.append(sanno)
        }
        
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotations(annotations)
        self.mapView.showAnnotations(self.mapView.annotations, animated: false)
    }
    
    @IBAction func onUpdateRegion(_ sender: Any) {
        if !enterMapViewGesture {
            let ca = viewModel.companyAnnotation
            self.mapView.setCenter(ca.coordinate, animated: true)
        }
    }
    
}

extension MultitouchMonitorViewController : UIGestureRecognizerDelegate
{
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        print("gestureRecognizerShouldBegin:")
        enterMapViewGesture = true
        enterMapViewGestureLabel.isHidden = false
        
        return false
    }
}

extension MultitouchMonitorViewController : MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        print("mapView: regionWillChangeAnimated")
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("mapView: regionDidChangeAnimated")
        enterMapViewGesture = false
        enterMapViewGestureLabel.isHidden = true
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
        
        if let sanno = annotation as? ShopAnnotation {
            var annov = mapView.dequeueReusableAnnotationView(withIdentifier: sanno.type.resourceId() )
            if annov == nil {
                let sannov = SimpleShopAnnotationView(annotation: sanno, reuseIdentifier: sanno.type.resourceId())
                sannov.image = UIImage(named:"pin")
                sannov.title = sanno.type.glyphText()
                
                annov = sannov
            } else {
                annov?.annotation = sanno
            }
            
            return annov
        }
        return nil
    }
}
