
import Foundation
import UIKit


class ViewRound: UIView {
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = true
    }
    
}

class ViewWithCornerRadius: UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
}

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

class ViewWithSadowAndCorner: UIView {
    
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
    
    func addShadow(shadowColor: CGColor = UIColor.lightGray.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 1.0),
                   shadowOpacity: Float = 0.5,
                   shadowRadius: CGFloat = 2.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}

class GradientView: UIView {
    
    var firstColor1: UIColor = UIColor.red
    var secondColor1: UIColor = UIColor.green
    var vertical1: Bool = true
    
    @IBInspectable var firstColor: UIColor = .red {
        didSet {
            self.firstColor1 = firstColor
        }
    }
    
    @IBInspectable var secondColor: UIColor = .green {
        didSet {
            self.secondColor1 = secondColor
        }
    }
    
    @IBInspectable var vertical: Bool = true {
        didSet {
            self.vertical1 = vertical
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        applyGradient()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        applyGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient()
    }
    
    func applyGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [firstColor1.cgColor, secondColor1.cgColor]
        if vertical1 {
            gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        } else {
            gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        }
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.sublayers = [gradientLayer]
    }
    
}

