//
//  ShotAnnotation.swift
//  MapKitShowcase
//
//  Created by 能登 要 on 2018/01/26.
//  Copyright © 2018年 Kaname Noto. All rights reserved.
//

import UIKit
import MapKit

enum ShopAnnotationType : NSInteger {
    case freshnessburger = 0
    case seikarou = 1
    case tullyscoffee = 2
    case seveneleven = 3
    case lotteria = 4
    case dipperdan = 5
    case kfc = 6
    
    func coordinate() -> CLLocationCoordinate2D {
        switch self {
        case .freshnessburger:
            // https://maps.apple.com/?q=43.065437,141.362620&sll=43.065437,141.362620&sspn=0.001681,0.002428&t=m
             return CLLocationCoordinate2DMake(43.065437,141.362620)
        case .seikarou:
            // https://maps.apple.com/?q=43.065501,141.363019&sll=43.065501,141.363019&sspn=0.001681,0.002428&t=m
            return CLLocationCoordinate2DMake(43.065501,141.363019)
        case .tullyscoffee:
            // https://maps.apple.com/?q=43.065136,141.362275&sll=43.065136,141.362275&sspn=0.001681,0.002428&t=m
            return CLLocationCoordinate2DMake(43.065136,141.362275)
        case .seveneleven:
            // https://maps.apple.com/?q=43.065432,141.362552&sll=43.065432,141.362552&sspn=0.001681,0.002428&t=m
            return CLLocationCoordinate2DMake(43.065432,141.362552)
        case .lotteria:
            // https://maps.apple.com/?q=43.064504,141.362871&sll=43.064504,141.362871&sspn=0.001883,0.002720&t=m
            return CLLocationCoordinate2DMake(43.064504,141.362871)
        case .dipperdan:
            // https://maps.apple.com/?q=43.065408,141.362890&sll=43.065408,141.362890&sspn=0.001883,0.002720&t=m
            return CLLocationCoordinate2DMake(43.065408,141.362890)
        case .kfc:
            // https://maps.apple.com/?q=43.065372,141.363064&sll=43.065372,141.363064&sspn=0.001883,0.002720&t=m
            return CLLocationCoordinate2DMake(43.065372,141.363064)
        }
    }
    
    func resourceId() -> String {
        switch self {
        case .freshnessburger:
            return "freshnessburger"
        case .seikarou:
            return "seikarou"
        case .tullyscoffee:
            return "tullyscoffee"
        case .seveneleven:
            return "seveneleven"
        case .lotteria:
            return "lotteria"
        case .dipperdan:
            return "dipperdan"
        case .kfc:
            return "kfc"
        }
    }
    
    func glyphText() -> String {
        switch self {
        case .freshnessburger:
            return "F"
        case .seikarou:
            return "星"
        case .tullyscoffee:
            return "t"
        case .seveneleven:
            return "7"
        case .lotteria:
            return "L"
        case .dipperdan:
            return "D"
        case .kfc:
            return "K"
        }
    }
    
    func tintColor() -> UIColor {
        switch self {
        case .freshnessburger:
            return UIColor(displayP3Red: 0.031, green: 0.365, blue: 0.239, alpha: 1.0)
        case .seikarou:
            return UIColor.red
        case .tullyscoffee:
            return UIColor(displayP3Red: 0.137, green: 0.094, blue: 0.082, alpha: 1.0)
        case .seveneleven:
            return UIColor(displayP3Red: 0.937, green: 0.510, blue: 0.102, alpha: 1.0)
        case .lotteria:
            return UIColor(displayP3Red: 0.894, green: 0.000, blue: 0.055, alpha: 1.0)
        case .dipperdan:
            return UIColor(displayP3Red: 0.075, green: 0.094, blue: 0.431, alpha: 1.0)
        case .kfc:
            return UIColor.red
        }
    }
    
    
}

class ShopAnnotation: MKPointAnnotation {
    public let type:ShopAnnotationType
    
    init(_ type:ShopAnnotationType) {
        self.type = type
        super.init()
        self.coordinate = type.coordinate()
    }
    
}
