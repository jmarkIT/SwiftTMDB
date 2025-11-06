//
//  TMDBMovie.swift
//  wo-details-getter
//
//  Created by James Mark on 10/11/25.
//

public struct TMDBMovie: Codable {
    public let id: Int
    public let title: String
    public let budget: Int
    public let revenue: Int
    public let genres: [Genre]
    public let credits: Credits?
    public let runtime: Int
}

public enum Genre: Int, Codable {
    case action = 28
    case adventure = 12
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case mystery = 9648
    case romance = 10749
    case scienceFiction = 878
    case tvMovie = 10770
    case thriller = 53
    case war = 10752
    case western = 37
    case unknown
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(Int.self)
        self = Genre(rawValue: value) ?? .unknown
    }
}

public struct Credits: Codable {
    public let cast: [Credit]
    public let crew: [Credit]
}

public struct Credit: Codable {
    public let adult: Bool
    public let gender: Int
    public let id: Int
    public let knownForDepartment: String?
    public let name: String
    public let originalName: String
    public let popularity: Double
    public let profilePath: String?
    public let castId: Int?
    public let character: String?
    public let creditId: String
    public let order: Int?
    public let department: String?
    public let job: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castId = "cast_id"
        case character
        case creditId = "credit_id"
        case order
        case department
        case job
    }
}

