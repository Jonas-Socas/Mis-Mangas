//
//  URL.swift
//  TrantorLibrary
//
//  Created by Julio César Fernández Muñoz on 21/11/23.
//

import Foundation

let api = URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com")!

extension URL {
    static let getMangas = api.appending(path: "/list/mangas")
    static let getMangasByBeginWith = api.appending(path: "/search/mangasBeginsWith")
    static let getMangasByContains = api.appending(path: "/search/mangasContains")
    
    func withQueryItems(_ queryItems: [String: String]) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        return (components?.url)!
    }
}
