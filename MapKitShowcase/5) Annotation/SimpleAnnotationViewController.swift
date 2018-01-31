//
//  SimpleAnnotationViewController.swift
//  MapKitShowcase
//
//  Created by 能登 要 on 2018/01/27.
//  Copyright © 2018年 Kaname Noto. All rights reserved.
//

import UIKit
import MapKit

class SimpleAnnotationViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    private let viewModel = ShowcaseViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let region = MKCoordinateRegionMakeWithDistance(viewModel.centerCordinate, 1400, 1400)
        
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
        let ca = viewModel.companyAnnotation

        self.mapView.setCenter(ca.coordinate, animated: true)
        
    }
    
    
}

extension SimpleAnnotationViewController : MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        print("mapView: regionWillChangeAnimated")
    }
 
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("mapView: regionDidChangeAnimated")
    }
    
//    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
//        print("mapViewWillStartLoadingMap")
//    }
//    
//    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
//        print("mapViewDidFinishLoadingMap")
//    }
//    
//    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
//        print("mapViewDidFailLoadingMap")
//    }
//    
//    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
//        print("mapViewWillStartRenderingMap")
//    }
//    
//    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
//        print("mapViewDidFinishRenderingMap")
//    }
    
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
