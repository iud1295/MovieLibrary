
import Foundation
import UIKit

class ImageViewWithCornerRadius: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
}


