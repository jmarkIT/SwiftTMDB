//
//  TMDBConfig.swift
//  wo-details-getter
//
//  Created by James Mark on 10/11/25.
//

import Foundation

struct TMDBConfig {
    static let apiBaseURL = URL(string: "https://api.themoviedb.org/3")!
    static let authToken = ProcessInfo.processInfo.environment["TMDB_TOKEN"] ?? ""
}
