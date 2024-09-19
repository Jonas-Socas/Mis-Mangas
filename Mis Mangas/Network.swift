//
//  Network.swift
//  TrantorLibrary
//
//  Created by Julio César Fernández Muñoz on 21/11/23.
//

import SwiftUI

protocol DataInteractor {
    func fetchPaginatedMangas(query: String, url: URL, page: Int, limit: Int) async throws -> PaginatedResponse<Manga>
    func fetchMangas(query: String, url: URL) async throws -> [Manga]
    func fetchPaginatedMangas(url: URL, page: Int, limit: Int) async throws -> PaginatedResponse<Manga>
    func fetchMangas(url: URL) async throws -> [Manga]
    func fetchAuthors() async throws -> [Author]
    func fetchDemographics() async throws -> [String]
    func fetchGenres() async throws -> [String]
    func fetchThemes() async throws -> [String]
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
    
    func fetchPaginatedMangas(query: String, url: URL, page: Int, limit: Int) async throws -> PaginatedResponse<Manga> {
        let url = url
            .appending(component: query)
            .withQueryItems(["page" : String(page), "per" : String(limit)])
        return try await getJSON(request: .get(url: url), type: PaginatedResponse<Manga>.self)
    }
    
    func fetchMangas(query: String, url: URL) async throws -> [Manga] {
        let url = url.appending(component: query)
        return try await getJSON(request: .get(url: url), type: [Manga].self)
    }
    
    func fetchPaginatedMangas(url: URL, page: Int, limit: Int) async throws -> PaginatedResponse<Manga> {
        let url = url
            .withQueryItems(["page" : String(page), "per" : String(limit)])
        return try await getJSON(request: .get(url: url), type: PaginatedResponse<Manga>.self)
    }
    
    func fetchMangas(url: URL) async throws -> [Manga] {
        return try await getJSON(request: .get(url: url), type: [Manga].self)
    }
    
    func fetchAuthors() async throws -> [Author] {
        return try await getJSON(request: .get(url: URL.getAuthors), type: [Author].self)
    }
    
    func fetchDemographics() async throws -> [String] {
        return try await getJSON(request: .get(url: URL.getDemographics), type: [String].self)
    }
    
    func fetchGenres() async throws -> [String] {
        return try await getJSON(request: .get(url: URL.getGenres), type: [String].self)
    }
    
    func fetchThemes() async throws -> [String] {
        return try await getJSON(request: .get(url: URL.getThemes), type: [String].self)
    }
}
