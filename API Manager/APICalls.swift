
import Foundation

class APICalls {

    let manager = APIManager.init()

    func getConfigurations(completion: @escaping (_ result: ConfigModel?) -> ()) {

        manager.getAPICall(url: APIDomain.Configuration, parameters: PostParameters().getConfigParams(), authRequired: false, userToken: "") { (result, error) in
            if error != nil {
                print(error ?? "")
                completion(nil)
            } else {
                print(result as! NSDictionary)
                let response = ConfigModel.init(dictionary: result as! NSDictionary)
                completion(response)
            }
        }
    }

    func getMovieList(pageNo: Int, completion: @escaping (_ result: MovieListModel?) -> ())  {

        manager.getAPICall(url: APIDomain.PopularMovies, parameters: PostParameters().getPopularMovieListParams(pageNo: pageNo), authRequired: false, userToken: "") { (result, error) in
            if error != nil {
                print(error ?? "")
                completion(nil)
            } else {
                print(result as! NSDictionary)

                let response = MovieListModel.init(dictionary: result as! NSDictionary)
                completion(response)
            }
        }
    }

    func getMovieDetails(id: Int, completion: @escaping (_ result: MovieDetailModel?) -> ())  {
        
        manager.getAPICall(url: APIDomain.MovieDetails+"\(id)", parameters: PostParameters().getMovieDetailParams(), authRequired: false, userToken: "") { (result, error) in
            if error != nil {
                print(error ?? "")
                completion(nil)
            } else {
                print(result as! NSDictionary)
                
                let response = MovieDetailModel.init(dictionary: result as! NSDictionary)
                completion(response)
            }
        }
    }
    
}
