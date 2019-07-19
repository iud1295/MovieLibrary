
import Foundation
import UIKit
import CoreLocation
import AFNetworking

extension UIViewController {
    
//    func setDefaultNavigationBar() {
//        UINavigationBar.appearance().barTintColor = .white
//        UINavigationBar.appearance().isTranslucent = true
//        UINavigationBar.appearance().tintColor = UIColor.init(hexString: AppColors.Primary)
//        
//        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.black]
//        UISearchBar.appearance().barStyle = UIBarStyle.default
//    }
//    
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
    
    func getDocumentsURL() -> String {
        let documentsURL = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]//FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsURL
    }
    
    func fileInDocumentsDirectory(filename: String) -> String {
        
        let fileURL = URL.init(string: getDocumentsURL())?.appendingPathComponent(filename)
        return fileURL!.path
        
    }
    
    func saveImageToDocumentsDirectory(name: String, image: UIImage) -> Bool {
        let path = getDocumentsDirectoryPath(filename: name)
        
        let imgData = image.pngData()! as NSData
        let result = imgData.write(toFile: path, atomically: true)
        return result
    }
    
    func getImageFromDocumentsDirectory(name: String) -> UIImage? {
        let path = getDocumentsDirectoryPath(filename: name)
        
        if let image = UIImage(contentsOfFile: path) {
            return image
        } else {
            return nil
        }
    }
    
    func deleteImageInDocumentsDirectory(name: String)  {
        let filePath = self.getDocumentsDirectoryPath(filename: name)
        
        if (FileManager.default.fileExists(atPath: filePath)) {
            do {
                try FileManager.default.removeItem(atPath: filePath)
            }
            catch let error as NSError {
                print("Ooops! Something went wrong: \(error)")
            }
        }
    }
    
    func getDocumentsDirectoryPath(filename: String) -> String {
        let documentsURL = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let fileURL = URL.init(string: documentsURL)?.appendingPathComponent(filename)
        return fileURL!.path
    }
    
    func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) -> String {
        if let error = error {
            print("Unable to Reverse Geocode Location (\(error))")
            print("Unable to Find Address for Location")
            return ""
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                return placemark.compactAddress!
            } else {
                print("No Matching Addresses Found")
                return ""
            }
        }
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


extension CLPlacemark {
    
    var compactAddress: String? {
        
        if let name = name {
            var result = name
//            if let street = thoroughfare {
//                result += ", \(street)"
//            }
            if let subLocality = subLocality {
                result += ", \(subLocality)"
            }
//            if let locality = locality {
//                result += ", \(locality)"
//            }
            return result
        }
        return nil
    }
    
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
