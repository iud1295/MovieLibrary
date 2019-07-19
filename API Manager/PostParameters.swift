
import Foundation
import CoreLocation

class PostParameters {
    
    func getConfigParams() -> NSDictionary {
        return ["api_key": MovieDBAPIKey.Key]
    }
    
    func getPopularMovieListParams() -> NSDictionary {
        return ["api_key": MovieDBAPIKey.Key,
                "language": "en-US",
                "page": 1]
    }
    
}
