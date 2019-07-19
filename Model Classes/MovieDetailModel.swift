
import Foundation

// MARK: - MovieDetailModel
class MovieDetailModel: Codable {
    let genres: [Genre]
    let id: Int
    let originalTitle, overview, posterPath, backdropPath: String
    let productionCompanies: [ProductionCompany]
    let releaseDate: String
    let runtime: Int
    let status, title: String
    let voteAverage: Double
    let videos: Videos
    
    enum CodingKeys: String, CodingKey {
        case genres, id
        case originalTitle = "original_title"
        case overview
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case releaseDate = "release_date"
        case runtime, status, title
        case voteAverage = "vote_average"
        case videos
    }
    
    init(genres: [Genre], id: Int, originalTitle: String, backdropPath: String, overview: String, posterPath: String, productionCompanies: [ProductionCompany], releaseDate: String, runtime: Int, status: String, title: String, voteAverage: Double, videos: Videos) {
        self.genres = genres
        self.id = id
        self.originalTitle = originalTitle
        self.overview = overview
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
        self.runtime = runtime
        self.status = status
        self.title = title
        self.voteAverage = voteAverage
        self.videos = videos
    }
    
    init(dictionary: NSDictionary) {
        
        var genreArr = [Genre]()
        let arr1 = dictionary.object(forKey: CodingKeys.genres.rawValue) as? NSArray ?? []
        for i in arr1 {
            genreArr.append(Genre.init(dictionary: i as! NSDictionary))
        }
        self.genres = genreArr
        
        self.id = dictionary.object(forKey: CodingKeys.id.rawValue) as? Int ?? 0
        self.originalTitle = dictionary.object(forKey: CodingKeys.originalTitle.rawValue) as? String ?? ""
        self.overview = dictionary.object(forKey: CodingKeys.overview.rawValue) as? String ?? ""
        self.posterPath = dictionary.object(forKey: CodingKeys.posterPath.rawValue) as? String ?? "http://www.theprintworks.com/wp-content/themes/psBella/assets/img/film-poster-placeholder.png"
        self.backdropPath = dictionary.object(forKey: CodingKeys.backdropPath.rawValue) as? String ?? "http://www.theprintworks.com/wp-content/themes/psBella/assets/img/film-poster-placeholder.png"
        
        var productionCompaniesArr = [ProductionCompany]()
        let arr2 = dictionary.object(forKey: CodingKeys.productionCompanies.rawValue) as? NSArray ?? []
        for i in arr2 {
            productionCompaniesArr.append(ProductionCompany.init(dictionary: i as! NSDictionary))
        }
        self.productionCompanies = productionCompaniesArr
        
        self.releaseDate = dictionary.object(forKey: CodingKeys.releaseDate.rawValue) as? String ?? ""
        self.runtime = dictionary.object(forKey: CodingKeys.runtime.rawValue) as? Int ?? 0
        self.status = dictionary.object(forKey: CodingKeys.status.rawValue) as? String ?? ""
        self.title = dictionary.object(forKey: CodingKeys.title.rawValue) as? String ?? ""
        self.voteAverage = dictionary.object(forKey: CodingKeys.voteAverage.rawValue) as? Double ?? 0.0
        
        self.videos = Videos.init(dictionary: dictionary.object(forKey: CodingKeys.videos.rawValue) as? NSDictionary ?? [:])
    }
    
}

// MARK: - Genre
class Genre: Codable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(dictionary: NSDictionary) {
        self.id = dictionary.object(forKey: CodingKeys.id.rawValue) as? Int ?? 0
        self.name = dictionary.object(forKey: CodingKeys.name.rawValue) as? String ?? ""
    }
    
}

// MARK: - ProductionCompany
class ProductionCompany: Codable {
    let id: Int
    let logoPath, name, originCountry: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
    
    init(id: Int, logoPath: String, name: String, originCountry: String) {
        self.id = id
        self.logoPath = logoPath
        self.name = name
        self.originCountry = originCountry
    }
    
    init(dictionary: NSDictionary) {
        self.id = dictionary.object(forKey: CodingKeys.id.rawValue) as? Int ?? 0
        self.logoPath = dictionary.object(forKey: CodingKeys.logoPath.rawValue) as? String ?? ""
        self.name = dictionary.object(forKey: CodingKeys.name.rawValue) as? String ?? ""
        self.originCountry = dictionary.object(forKey: CodingKeys.originCountry.rawValue) as? String ?? ""
    }
    
}

// MARK: - Videos
class Videos: Codable {
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(results: [Result]) {
        self.results = results
    }
    
    init(dictionary: NSDictionary) {
        
        var temp = [Result]()
        let arr = dictionary.object(forKey: CodingKeys.results.rawValue) as? NSArray ?? []
        
        for i in arr {
            let item = Result.init(dictionary: i as! NSDictionary)
            if arr.count == 1 {
                temp.append(item)
                break
            } else if item.type.lowercased() == "trailer" {
                temp.append(item)
                break
            }
        }
        self.results = temp
    }
    
}

// MARK: - Result
class Result: Codable {
    let id, key, name, site: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id, key, name, site, type
    }
    
    init(id: String, key: String, name: String, site: String, type: String) {
        self.id = id
        self.key = key
        self.name = name
        self.site = site
        self.type = type
    }
    
    init(dictionary: NSDictionary) {
        self.id = dictionary.object(forKey: CodingKeys.id.rawValue) as? String ?? ""
        self.key = dictionary.object(forKey: CodingKeys.key.rawValue) as? String ?? ""
        self.name = dictionary.object(forKey: CodingKeys.name.rawValue) as? String ?? ""
        self.site = dictionary.object(forKey: CodingKeys.site.rawValue) as? String ?? ""
        self.type = dictionary.object(forKey: CodingKeys.type.rawValue) as? String ?? ""
    }
    
}

