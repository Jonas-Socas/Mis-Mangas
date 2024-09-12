//
//  Network.swift
//  TrantorLibrary
//
//  Created by Julio César Fernández Muñoz on 21/11/23.
//

import SwiftUI

protocol DataInteractor {
    func fetchPaginatedMangas(url: URL, page: Int, limit: Int) async throws -> PaginatedResponse<Manga>
    func searchMangas(query: String, searchType: SearchType, page: Int, limit: Int) async throws -> [Manga]
}

struct Network: DataInteractor {
    static let shared = Network()
    
    private func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws -> JSON where JSON: Decodable {
        let (data, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode == 200 {
            do {
                return try JSONDecoder().decode(type, from: data)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func fetchPaginatedMangas(url: URL, page: Int, limit: Int) async throws -> PaginatedResponse<Manga> {
        let url = url.withQueryItems(["page" : String(page), "per" : String(limit)])
        return try await getJSON(request: .get(url: url), type: PaginatedResponse<Manga>.self)
    }
    
    func searchMangas(query: String, searchType: SearchType, page: Int, limit: Int) async throws -> [Manga] {
        switch searchType {
        case .beginsWith:
            return try await getJSON(request: .get(url: URL.getMangasByBeginWith.appending(path: query)), type: [Manga].self)
        case .contains:
            return try await fetchPaginatedMangas(url: URL.getMangasByContains.appending(component: query), page: page, limit: limit).items
        }
    }
}
