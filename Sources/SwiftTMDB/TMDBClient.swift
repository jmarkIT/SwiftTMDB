//
//  TMDBClient.swift
//  wo-details-getter
//
//  Created by James Mark on 10/11/25.
//

import Foundation

public class TMDBClient {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    private func makeRequest(
        endpoint: String,
        method: String = "GET",
        body: Data? = nil
    ) -> URLRequest {
        var request = URLRequest(
            url: TMDBConfig.apiBaseURL.appending(path: endpoint)
        )
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(
            "Bearer \(TMDBConfig.authToken)",
            forHTTPHeaderField: "Authorization"
        )

        return request
    }

    func perform<T: Decodable>(
        _ endpoint: String,
        method: String = "GET",
        body: Data? = nil
    ) async throws -> T {
        let request = makeRequest(
            endpoint: endpoint,
            method: method,
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
    public func getMovie(movieId: String) async throws -> TMDBMovie {
        return try await perform("movie/\(movieId)")
    }
}
