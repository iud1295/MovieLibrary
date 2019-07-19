
import Foundation

// MARK: - MovieListModel
class MovieListModel: Codable {
    let page, totalResults, totalPages: Int
    let results: [MovieItem]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
    init(page: Int, totalResults: Int, totalPages: Int, results: [MovieItem]) {
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.results = results
    }
    
    init(dictionary: NSDictionary) {
        self.page = dictionary.object(forKey: CodingKeys.page.rawValue) as? Int ?? 0
        self.totalResults = dictionary.object(forKey: CodingKeys.totalResults.rawValue) as? Int ?? 0
        self.totalPages = dictionary.object(forKey: CodingKeys.totalPages.rawValue) as? Int ?? 0
        
        var temp = [MovieItem]()
        let arr = dictionary.object(forKey: CodingKeys.results.rawValue) as? NSArray ?? []
        for i in arr {
            temp.append(MovieItem.init(dictionary: i as! NSDictionary))
        }
        self.results = temp
    }
    
}

// MARK: - Result
class MovieItem: Codable {
    let id: Int
    let voteAverage: Double
    let title: String
    let posterPath: String
    let originalTitle: String
    let overview, releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case voteAverage = "vote_average"
        case title
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
    }
    
    init(id: Int, voteAverage: Double, title: String, posterPath: String, originalTitle: String, overview: String, releaseDate: String) {
        self.id = id
        self.voteAverage = voteAverage
        self.title = title
        self.posterPath = posterPath
        self.originalTitle = originalTitle
        self.overview = overview
        self.releaseDate = releaseDate
    }
    
    init(dictionary: NSDictionary) {
        self.id = dictionary.object(forKey: CodingKeys.id.rawValue) as? Int ?? 0
        self.voteAverage = dictionary.object(forKey: CodingKeys.voteAverage.rawValue) as? Double ?? 0.0
        self.title = dictionary.object(forKey: CodingKeys.title.rawValue) as? String ?? ""
        self.posterPath = dictionary.object(forKey: CodingKeys.posterPath.rawValue) as? String ?? "http://www.theprintworks.com/wp-content/themes/psBella/assets/img/film-poster-placeholder.png"
        self.originalTitle = dictionary.object(forKey: CodingKeys.originalTitle.rawValue) as? String ?? ""
        self.overview = dictionary.object(forKey: CodingKeys.overview.rawValue) as? String ?? ""
        self.releaseDate = dictionary.object(forKey: CodingKeys.releaseDate.rawValue) as? String ?? ""
    }
    
}
