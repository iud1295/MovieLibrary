
import Foundation
import UIKit
import AFNetworking

extension UIViewController {
     
    func showAlert(title : String?, message : String?) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showToastMessage(messageString : String, duration: Double = 1.5) {
        let message = NSMutableAttributedString(string: messageString)
        
        var alert : UIAlertController!
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ){
            alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        } else {
            alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        }
        
        message.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 15.0), range: NSRange(location: 0, length: message.length))
        message.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: message.length))
        
        alert.setValue(message, forKey: "attributedTitle")
        self.present(alert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func getFullDate(date: String) -> String {
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd"
        // initially set the format based on your datepicker date / server String
        
        // convert your string to date
        let yourDate = isoFormatter.date(from: date)!
        
        let formatter = DateFormatter()
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd MMMM YYYY"
        // again convert your date to string
        let formattedString = formatter.string(from: yourDate)

        return formattedString
        
    }
    
    func getDateYear(date: String) -> String {
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd"
        // initially set the format based on your datepicker date / server String
        
        // convert your string to date
        let yourDate = isoFormatter.date(from: date)!
        
        let formatter = DateFormatter()
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "YYYY"
        // again convert your date to string
        let formattedString = formatter.string(from: yourDate)
        
        return formattedString
        
    }
    
    func getImageUrl(posterPath: String) -> URL {
        return URL(string: (UserDefaults.standard.object(forKey: AppUserDefaults.ImageBaseURL) as! String + "original" + posterPath))!
    }
    
}

extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
