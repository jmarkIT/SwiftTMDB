//
//  TMDBMovie.swift
//  wo-details-getter
//
//  Created by James Mark on 10/11/25.
//

public struct TMDBMovie: Codable {
    public let title: String
    public let budget: Int
    public let revenue: Int
    public let genres: [Genre]
    public let credits: Credits
}

public struct Genre: Codable {
    public let id: Int
    public let name: String
}

public struct Credits: Codable {
    public let cast: [Credit]
    public let crew: [Credit]
}

public struct Credit: Codable {
    public let adult: Bool
    public let gender: Int
    public let id: Int
    public let knownForDepartment: String
    public let name: String
    public let originalName: String
    public let popularity: Double
    public let profilePath: String?
    public let castId: Int?
    public let character: String
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
