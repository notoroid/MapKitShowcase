//
//  ConpassAndScaleViewController.swift
//  MapKitShowcase
//
//  Created by 能登 要 on 2018/01/26.
//  Copyright © 2018年 Kaname Noto. All rights reserved.
//

import UIKit
import MapKit

class ConpassAndScaleViewController: UIViewController {
    public var coordinateForInitialized:CLLocationCoordinate2D? = nil
    @IBOutlet public weak var mapView: MKMapView!

    enum PickerComponent : Int {
        case Conpass = 0
        case Scale = 1
    }
    
    private let dictForPicker:[[String]] = [["標準コンパスあり","標準コンパスなし"],["標準スケールあり","標準スケールなし"]]
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // マップにユーザの現在地を表示
        if let coordinateForInitialized = coordinateForInitialized {
            let coordinate = coordinateForInitialized
            
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 1400, 1400)
            
            mapView.setRegion(region, animated: true)
        }
                
        mapView.showsCompass = false
        mapView.showsScale = false
        
        // ピッカー情報を更新
        pickerView.selectRow(mapView.showsCompass ? 0 : 1, inComponent: PickerComponent.Conpass.rawValue, animated: true)
        pickerView.selectRow(mapView.showsScale ? 0 : 1, inComponent: PickerComponent.Scale.rawValue, animated: true)
        
        // スケールを表示
        let scale = MKScaleView(mapView: mapView)
        scale.legendAlignment = .trailing
        self.navigationItem.titleView = scale
        
        // コンパスを表示
        let compass = MKCompassButton(mapView: mapView)
        compass.compassVisibility = .visible
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: compass)
    }
}

extension ConpassAndScaleViewController : UIPickerViewDelegate
{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch PickerComponent(rawValue: component) {
        case .Conpass?:
            mapView.showsCompass = row == 0 ? true : false
            break
        case .Scale?:
            mapView.showsScale = row == 0 ? true : false
            break
        case .none:
            break
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let title = dictForPicker[component][row
        ]
        return title
    }
}

extension ConpassAndScaleViewController : UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
}

