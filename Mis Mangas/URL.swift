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
    static let getMangasByGenre  = api.appending(path: "/list/mangaByGenre")
    static let getMangasByAuthor = api.appending(path: "/list/mangaByAuthor")
    static let getMangasByTheme = api.appending(path: "/list/mangaByTheme")
    static let getMangasByDemographic = api.appending(path: "/list/mangaByDemographic")
    static let getAuthors = api.appending(path: "/list/authors")
    static let getDemographics = api.appending(path: "/list/demographics")
    static let getGenres = api.appending(path: "/list/genres")
    static let getThemes = api.appending(path: "/list/themes")
    static let getMangaByID = api.appending(path: "/search/manga")
    
    func withQueryItems(_ queryItems: [String: String]) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        return (components?.url)!
    }
}
