//
//  CompanyAnnotation.swift
//  MapKitShowcase
//
//  Created by 能登 要 on 2018/01/26.
//  Copyright © 2018年 Kaname Noto. All rights reserved.
//

import UIKit
import MapKit

class CompanyAnnotation: MKPointAnnotation {

    public func resouceId() -> String {
        return "company"
    }
    
    public func imageNamed() -> UIImage? {
        return UIImage(named: "company")
    }
    
}
