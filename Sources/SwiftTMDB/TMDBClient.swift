//
//  TMDBClient.swift
//  wo-details-getter
//
//  Created by James Mark on 10/11/25.
//

import Foundation

public actor TMDBClient {
    private let session: URLSession
    private let cfg: TMDBConfig

    public init(session: URLSession = .shared, cfg: TMDBConfig) {
        self.session = session
        self.cfg = cfg
    }

    private func makeRequest(
        endpoint: String,
        method: String = "GET",
        queryItems: [URLQueryItem]? = nil,
        body: Data? = nil
    ) -> URLRequest {
        let baseURL = TMDBConfig.apiBaseURL.appending(path: endpoint)
        var components = URLComponents(
            url: baseURL,
            resolvingAgainstBaseURL: false
        )!
        components.queryItems = queryItems?.isEmpty == false ? queryItems : nil
        guard let url = components.url else {
            fatalError("Invalid URL components for endpoint: \(endpoint)")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(
            "Bearer \(cfg.authToken)",
            forHTTPHeaderField: "Authorization"
        )

        return request
    }

    func perform<T: Decodable>(
        _ endpoint: String,
        method: String = "GET",
        queryItems: [URLQueryItem]? = nil,
        body: Data? = nil
    ) async throws -> T {
        let request = makeRequest(
            endpoint: endpoint,
            method: method,
            queryItems: queryItems,
            body: body
        )
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        // TODO: Implement check for TMDB Error

        return try JSONDecoder().decode(T.self, from: data)
    }
}

extension TMDBClient {
    public func getMovie(movieId: String, appendToResponse: [String]? = nil)
        async throws -> TMDBMovie
    {
        return try await perform(
            "movie/\(movieId)",
            method: "GET",
            queryItems: appendToResponse.map {
                [
                    URLQueryItem(
                        name: "append_to_response",
                        value: $0.joined(separator: ",")
                    )
                ]
            },
            body: nil,
        )
    }
}

extension TMDBClient {
    public func getGenres() async throws -> [Genre] {
        let genresQueryResponse: GenresQuery = try await perform(
            "genre/movie/list",
            method: "GET",
            queryItems: nil,
            body: nil
        )
        return genresQueryResponse.genres
    }
}
