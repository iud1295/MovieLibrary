
import Foundation
import CoreLocation

class PostParameters {
    
    func getConfigParams() -> NSDictionary {
        return ["api_key": MovieDBAPIKey.Key]
    }
    
    func getPopularMovieListParams(pageNo: Int) -> NSDictionary {
        return ["api_key": MovieDBAPIKey.Key,
                "language": "en-US",
                "page": pageNo]
    }
    
    func getMovieDetailParams() -> NSDictionary {
        return ["api_key": MovieDBAPIKey.Key,
                "language": "en-US",
                "append_to_response": "videos"]
    }
    
}
