//
//  Network.swift
//  TrantorLibrary
//
//  Created by Julio César Fernández Muñoz on 21/11/23.
//

import SwiftUI

protocol DataInteractor {
    func fetchMangas(page: Int, limit: Int) async throws -> PaginatedResponse<Manga>
}

struct Network: DataInteractor {
    static let shared = Network()
    
    func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws -> JSON where JSON: Decodable {
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
    
    func fetchMangas(page: Int, limit: Int) async throws -> PaginatedResponse<Manga> {
        let url = URL.getMangas.withQueryItems(["page" : String(page), "per" : String(limit)])
        return try await getJSON(request: .get(url: url), type: PaginatedResponse<Manga>.self)
    }
}
