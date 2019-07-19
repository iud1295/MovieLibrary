
import Foundation
import UIKit

struct APIDomain {
    // MARK: - Development Url
    static let ServerUrl = "https://api.themoviedb.org/"
    
    // MARK: - Production Url
    //    static let ServerUrl = ""
    
    static let folder = "3/"
    
    // MARK: - EndPoints
    static let Configuration = APIDomain.ServerUrl + APIDomain.folder + "configuration"
    static let PopularMovies = APIDomain.ServerUrl + APIDomain.folder + "movie/popular"
    static let MovieDetails = APIDomain.ServerUrl + APIDomain.folder + "movie/"
    
}


struct AppUserDefaults {
    static let RecievedConfigSucces = "recievedConfigSucces"
    static let ImageBaseURL = "imageBaseURL"
}

struct AppColors {
//    static let Primary = UIColor.init(hexString: "#938FFA")
}

struct AppNotifications {
    static let RefreshMovieList = "refreshMovieList"
}

struct MovieDBAPIKey {
    static let Key = "4a546a912523c91b4d32c872a25b6374"
}

struct DatabaseTables {
    static let Config = "Config"
    static let Movies = "Movies"
}
