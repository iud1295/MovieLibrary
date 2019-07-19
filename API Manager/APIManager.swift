
import Foundation
import AFNetworking

class APIManager {
    
    func getDateForHeader() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyMMdd"
        let dateString = formatter.string(from: Date())
        return dateString
    }
    
    func postAPICall(url : String , parameters : Any?, authRequired: Bool, userToken: String, completion: @escaping (_ result: Any?, _ error: Error?) -> ()) {
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        if authRequired {
            manager.requestSerializer.setValue("Bearer "+userToken, forHTTPHeaderField: "Authorization")
        } else {
            manager.requestSerializer.clearAuthorizationHeader()
        }
        
        manager.responseSerializer.acceptableContentTypes = getAcceptableContentType()
        
        manager.post(url, parameters: parameters, progress: nil, success: { (URLSessionDataTask,responseObject ) in
            
            completion(responseObject, nil)
            
        }, failure: {(URLSessionDataTask , error) in
            
            completion(nil, error)
            self.showErrorAlert(error: error)
            
        })
    }
    
    func postAPICallWithImageArray(url : String , parameters : Any?, images: [Data]?, imageKey: String, authRequired: Bool, userToken: String, completion: @escaping (_ result: Any?, _ error: Error?) -> ()) {
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        if authRequired {
            manager.requestSerializer.setValue("Bearer "+userToken, forHTTPHeaderField: "Authorization")
        } else {
            manager.requestSerializer.clearAuthorizationHeader()
        }
        
        manager.responseSerializer.acceptableContentTypes = getAcceptableContentType()
        
        manager.post(url, parameters: parameters, constructingBodyWith: { (formData: AFMultipartFormData!) in
            
            for i in images ?? [] {
                formData.appendPart(withFileData: i, name: imageKey, fileName: "j.jpg", mimeType: "image/jpg")
            }
            
        }, progress: nil, success: { (URLSessionDataTask,responseObject ) in
            
            completion(responseObject, nil)
            
        }, failure: {(URLSessionDataTask , error) in
            
            completion(nil, error)
            self.showErrorAlert(error: error)
            
        })
    }
    
    func postAPICallWithImage(url : String , parameters : Any?, image: Data?, imageKey: String, authRequired: Bool, userToken: String, completion: @escaping (_ result: Any?, _ error: Error?) -> ()) {
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        if authRequired {
            manager.requestSerializer.setValue("Bearer "+userToken, forHTTPHeaderField: "Authorization")
        } else {
            manager.requestSerializer.clearAuthorizationHeader()
        }
        
        manager.responseSerializer.acceptableContentTypes = getAcceptableContentType()
        
        manager.post(url, parameters: parameters, constructingBodyWith: { (formData: AFMultipartFormData!) in
            
            if let img = image {
                formData.appendPart(withFileData: img, name: imageKey, fileName: "j.jpg", mimeType: "image/jpg")
            }
            
        }, progress: nil, success: { (URLSessionDataTask,responseObject ) in
            
            completion(responseObject, nil)
            
        }, failure: {(URLSessionDataTask , error) in
            
            completion(nil, error)
            self.showErrorAlert(error: error)
            
        })
    }
    
    func getAPICall(url : String , parameters : Any?, authRequired: Bool, userToken: String, completion: @escaping (_ result: Any?, _ error: Error?) -> ()) {
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        if authRequired {
            manager.requestSerializer.setValue("Bearer "+userToken, forHTTPHeaderField: "Authorization")
        } else {
            manager.requestSerializer.clearAuthorizationHeader()
        }
        
        manager.responseSerializer.acceptableContentTypes = getAcceptableContentType()
        
        manager.get(url, parameters: parameters, progress: nil, success: {(URLSessionDataTask,responseObject ) in
            
            completion(responseObject,nil)
            
        }) {(URLSessionDataTask , error) in
            
            completion(nil,error)
            self.showErrorAlert(error: error)
            
        }
    }
    
    func putAPICall(url : String , parameters : Any?, authRequired: Bool, userToken: String, completion: @escaping (_ result: Any?, _ error: Error?) -> ()) {
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        if authRequired {
            manager.requestSerializer.setValue("Bearer "+userToken, forHTTPHeaderField: "Authorization")
        } else {
            manager.requestSerializer.clearAuthorizationHeader()
        }
        
        manager.responseSerializer.acceptableContentTypes = getAcceptableContentType()
        
        manager.put(url, parameters: parameters, success: { (URLSessionDataTask,responseObject ) in
            
            completion(responseObject, nil)
            
        }) { (URLSessionDataTask , error) in
            
            completion(nil, error)
            self.showErrorAlert(error: error)
            
        }
    }
    
    func patchAPICall(url : String , parameters : Any?, authRequired: Bool, userToken: String, completion: @escaping (_ result: Any?, _ error: Error?) -> ()) {
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        if authRequired {
            manager.requestSerializer.setValue("Bearer "+userToken, forHTTPHeaderField: "Authorization")
        } else {
            manager.requestSerializer.clearAuthorizationHeader()
        }
        
        manager.responseSerializer.acceptableContentTypes = getAcceptableContentType()
        
        manager.patch(url, parameters: parameters, success: { (URLSessionDataTask, responseObject) in
            
            completion(responseObject, nil)
            
        }) { (URLSessionDataTask, error) in
            
            completion(nil, error)
            self.showErrorAlert(error: error)
            
        }
        
    }
    
    func getAcceptableContentType() -> Set<String> {
        var set : Set<String> = Set.init()
        set.insert("text/html")
        set.insert("application/json")
        return set
    }
    
    func showErrorAlert(error: Error) {
        
        let top = UIApplication.topViewController()
        
        print(error.localizedDescription)
        
        if error.localizedDescription.contains("Internet connection") {
            if !(top?.isKind(of: UIAlertController.self))! {
                top?.showToastMessage(messageString: "No internet connection.")
            }
        } else {
            if !(top?.isKind(of: UIAlertController.self))! {
                let alert = UIAlertController(title: "Failed", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title:  "OK", style: UIAlertAction.Style.default) { (alertAction) -> Void in})
                top?.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    
}

