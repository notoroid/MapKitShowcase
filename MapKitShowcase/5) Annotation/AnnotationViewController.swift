//
//  AnnotationViewController.swift
//  MapKitShowcase
//
//  Created by 能登 要 on 2018/01/26.
//  Copyright © 2018年 Kaname Noto. All rights reserved.
//

import UIKit
import MapKit

class AnnotationViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    private let centerCordinate = CLLocationCoordinate2DMake(43.064506, 141.362703)
    private let shopAnnotations = [ShopAnnotation(.freshnessburger),
                                   ShopAnnotation(.seikarou),
                                   ShopAnnotation(.tullyscoffee),
                                   ShopAnnotation(.seveneleven),
                                   ShopAnnotation(.lotteria),
                                   ShopAnnotation(.dipperdan),
                                   ShopAnnotation(.kfc),]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let region = MKCoordinateRegionMakeWithDistance(centerCordinate, 1400, 1400)
        
        mapView.setRegion(region, animated: true)
        
        let ca = CompanyAnnotation()
        ca.coordinate = CLLocationCoordinate2DMake(43.064506, 141.362703)
        

        var annotations = [MKPointAnnotation]()
        annotations.append(ca)
        shopAnnotations.forEach { (sanno) in
            annotations.append(sanno)
        }
        
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotations(annotations)
        self.mapView.showAnnotations(self.mapView.annotations, animated: false)
    }

    
}

extension AnnotationViewController : MKMapViewDelegate
{
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }
            
            if let canno = annotation as? CompanyAnnotation {
                var annov = mapView.dequeueReusableAnnotationView(withIdentifier: canno.resouceId() )
                if annov == nil {
                    let mannov = MKMarkerAnnotationView(annotation: canno, reuseIdentifier: canno.resouceId())
                    mannov.glyphImage = canno.imageNamed()
                    mannov.displayPriority = .required
                    mannov.clusteringIdentifier = "company"
                    annov = mannov
                } else {
                    annov?.annotation = canno
                }

                return annov
            }
            
            if let sanno = annotation as? ShopAnnotation {
                var annov = mapView.dequeueReusableAnnotationView(withIdentifier: sanno.type.resourceId() )
                if annov == nil {
                    let mannov = MKMarkerAnnotationView(annotation: sanno, reuseIdentifier: sanno.type.resourceId())
                    mannov.glyphText = sanno.type.glyphText()
                    mannov.markerTintColor = sanno.type.tintColor()
                    mannov.clusteringIdentifier = "shop"
                    annov = mannov
                } else {
                    annov?.annotation = sanno
                }
                
                return annov
            }
            return nil
        }
}
