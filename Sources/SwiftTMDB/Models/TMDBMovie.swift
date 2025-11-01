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
}

public struct Genre: Codable {
    public let id: Int
    public let name: String
}
