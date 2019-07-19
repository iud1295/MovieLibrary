//
//  UIButtonUtilities.swift
//  CoffeeEscape
//
//  Created by Ninestack on 30/07/18.
//  Copyright © 2018 Ninestack. All rights reserved.
//

import Foundation
import UIKit

class ButtonWithSadowAndCorner: UIButton {
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    
    
    func addShadow(shadowColor: CGColor = UIColor.lightGray.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 1.0),
                   shadowOpacity: Float = 0.5,
                   shadowRadius: CGFloat = 2.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addShadow()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
    }
    
}
