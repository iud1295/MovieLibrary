
import Foundation
import UIKit

class ViewShadow: UIView {
    
    override func draw(_ rect: CGRect) {
        
        self.layer.shadowOffset=CGSize.zero
        self.layer.shadowRadius=3.0
        self.layer.shadowOpacity=0.4
        self.layer.shadowColor=UIColor.lightGray.cgColor
        self.layer.cornerRadius=2
    }
    
}

class ViewShadowWithOffset: UIView {
    
    var shadowColor1 = UIColor.clear
    var offset1 = CGSize.zero
    var shadowRadius1: CGFloat = 0.0
    
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            self.shadowColor1 = shadowColor
        }
    }
    
    @IBInspectable var offset: CGSize = .zero {
        didSet {
            self.offset1 = offset
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            self.shadowRadius1 = shadowRadius
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        self.layer.shadowOffset = offset1
        self.layer.shadowRadius = shadowRadius1
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = shadowColor1.cgColor
        self.layer.cornerRadius = 2
    }
    
}

class CircularViewWithShadow: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        makeCircular()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeCircular()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeCircular()
    }
    
    func makeCircular() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.shadowOffset = CGSize.init(width: 2, height: 2)
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowRadius = 3.0;
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowPath = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: self.frame.size.height/2).cgPath
        self.layer.masksToBounds=false
    }
    
}
