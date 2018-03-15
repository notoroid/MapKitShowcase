//
//  ShowcaseViewModel.swift
//  MapKitShowcase
//
//  Created by 能登 要 on 2018/01/27.
//  Copyright © 2018年 Kaname Noto. All rights reserved.
//

import Foundation
import MapKit

struct ShowcaseViewModel
{
    let centerCordinate = CLLocationCoordinate2DMake(43.064506, 141.362703)
    let companyAnnotation = CompanyAnnotation()
    let shopAnnotations = [ShopAnnotation(.freshnessburger),
                           ShopAnnotation(.seikarou),
                           ShopAnnotation(.tullyscoffee),
                           ShopAnnotation(.seveneleven),
                           ShopAnnotation(.lotteria),
                           ShopAnnotation(.dipperdan),
                           ShopAnnotation(.kfc),]
    
    let defaultRadius = CLLocationDistance(1400)
}
