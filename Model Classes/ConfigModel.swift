//
//  ConfigModel.swift
//  MovieLibrary
//
//  Created by Ninestack on 18/07/19.
//

import Foundation

// MARK: - ConfigModel
class ConfigModel: Codable {
    let images: Images
    
    enum CodingKeys: String, CodingKey {
        case images = "images"
    }
    
    init(images: Images) {
        self.images = images
    }
    
    init(dictionary: NSDictionary) {
        self.images = Images.init(dictionary: dictionary.object(forKey: CodingKeys.images.rawValue) as? NSDictionary ?? [:])
    }
    
}

// MARK: - Images
class Images: Codable {
    let baseURL: String
    let secureBaseURL: String
    
    enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case secureBaseURL = "secure_base_url"
    }
    
    init(baseURL: String, secureBaseURL: String) {
        self.baseURL = baseURL
        self.secureBaseURL = secureBaseURL
    }
    
    init(dictionary: NSDictionary) {
        self.baseURL = dictionary.object(forKey: CodingKeys.baseURL.rawValue) as? String ?? ""
        self.secureBaseURL = dictionary.object(forKey: CodingKeys.baseURL.rawValue) as? String ?? ""
    }
    
}
