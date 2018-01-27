//
//  SimpleShopAnnotationView.swift
//  MapKitShowcase
//
//  Created by 能登 要 on 2018/01/27.
//  Copyright © 2018年 Kaname Noto. All rights reserved.
//

import UIKit
import MapKit

class SimpleShopAnnotationView: MKAnnotationView {
    static let titleFrame = CGRect(x: 0, y: 0, width: 140, height: 12)
    let titleLabel:UILabel = UILabel.init(frame:SimpleShopAnnotationView.titleFrame )
    let titleFont = UIFont.systemFont(ofSize: 15)
    var title:String? {
        didSet {
            if let title = title {
                //                print("title=\(title)")
                
                titleLabel.text = title
                titleLabel.textAlignment = .center
                titleLabel.font = titleFont
                titleLabel.textColor = UIColor.black
                
                let size = sizeForString(title,contentSize:SimpleShopAnnotationView.titleFrame.size)
                var farme = titleLabel.frame
                farme.size.width = size.width
                titleLabel.frame = farme
                
                titleLabel.center.x = 0.5 * self.frame.size.width;
                titleLabel.center.y = 10 + titleFont.pointSize * 0.5;
                
                self.addSubview(titleLabel)
            }else{
                titleLabel.removeFromSuperview()
            }
        }
    }
    
    private func sizeForString(_ s:String,contentSize:CGSize) -> CGSize {
        let attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: titleFont]
        let bound = NSString(string:s).boundingRect(with: contentSize, options: .usesLineFragmentOrigin , attributes:attributes, context: nil)
        return bound.size
    }

}
