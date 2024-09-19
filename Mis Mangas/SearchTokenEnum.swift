//
//  SearchTokenEnum.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 11/9/24.
//

import Foundation

enum SearchTokenEnum: String, CaseIterable, Identifiable {
    case title = "Title"
    case author = "Author"
    case genre = "Genre"
    case theme = "Theme"
    case demographic = "Demographic"
    case beginWith = "Begin With"
    case contains = "Contains"
    
    var id: String { rawValue }
    
    var displayText: String {
        return rawValue
    }
    
    var url: URL {
        switch self {
        case .author:
            URL.getMangasByAuthor
        case .genre:
            URL.getMangasByGenre
        case .theme:
            URL.getMangasByTheme
        case .demographic:
            URL.getMangasByDemographic
        case .contains:
            URL.getMangasByContains
        case .beginWith:
            URL.getMangasByBeginWith
        default:
            URL.getMangas
        }
    }
    
    static var filtered: [String] {
        SearchTokenEnum.allCases
            .filter{![.beginWith, .contains].contains($0)}
            .map{$0.rawValue}
    }
}
