//
//  RegionAndCameraViewController.swift
//  MapKitShowcase
//
//  Created by 能登 要 on 2018/03/17.
//  Copyright © 2018年 Kaname Noto. All rights reserved.
//

import UIKit
import MapKit

class RegionAndCameraViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private let viewModel = ShowcaseViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.toolbarItems = [UIBarButtonItem(title: "会社表示", style: .plain, target: self, action: #selector(onShowCompany(_:))),
                             UIBarButtonItem(title: "全表示", style: .plain, target: self, action: #selector(onShowAnnotations(_:))),
                             UIBarButtonItem(title: "ズームイン", style: .plain, target: self, action: #selector(onZoomIn(_:))),
                             UIBarButtonItem(title: "ズームアウト", style: .plain, target: self, action: #selector(onZoomOut(_:)))]
        
        self.navigationController?.isToolbarHidden = false
        
        
        let region = MKCoordinateRegionMakeWithDistance(viewModel.centerCordinate, viewModel.defaultRadius, viewModel.defaultRadius)
        mapView.setRegion(region, animated: true)
        
        let ca = viewModel.companyAnnotation
        ca.coordinate = viewModel.companyCoordinate
        
        var annotations = [MKPointAnnotation]()
        annotations.append(ca)
        viewModel.shopAnnotations.forEach { (sanno) in
            annotations.append(sanno)
        }
        
        // アノテーションのセットアップ
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotations(annotations)
        self.mapView.showAnnotations(self.mapView.annotations, animated: false)
        
    }

    @objc func onShowCompany(_ sender:UIBarButtonItem){
        let region = MKCoordinateRegionMakeWithDistance(viewModel.centerCordinate, viewModel.defaultRadius, viewModel.defaultRadius)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func onShowAnnotations(_ sender:UIBarButtonItem){
        mapView.showAnnotations(mapView.annotations, animated: true)
    }

    @objc func onZoomIn(_ sender:UIBarButtonItem){
        if let newCamera = mapView.camera.copy() as? MKMapCamera {
            newCamera.altitude = newCamera.altitude * 0.5
            mapView.setCamera(newCamera, animated: true)
        }
    }

    @objc func onZoomOut(_ sender:UIBarButtonItem){
        if let newCamera = mapView.camera.copy() as? MKMapCamera {
            newCamera.altitude = newCamera.altitude * 1.5
            mapView.setCamera(newCamera, animated: true)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension RegionAndCameraViewController : MKMapViewDelegate
{
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
