
import UIKit
import NVActivityIndicatorView

class ActivityIndicator {
    
    func showIndicator(backgroundColor: UIColor?, message: String, indicatorColor: UIColor) {
        
        let activityData = ActivityData.init(size: nil, message: message, messageFont: nil, messageSpacing: nil, type: .ballRotateChase, color: indicatorColor, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: backgroundColor, textColor: nil)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
    }
    
    func hideIndicator() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
}
