//
//  Manga.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 5/9/24.
//

import Foundation

struct Manga: Decodable {
    var id: Int
    var title: String
    var titleJapanese: String?
    var titleEnglish: String?
    var mainPicture: String?
    var status: String
    var startDate: String?
    var endDate: String?
    var score: Float
    var volumes: Int?
    var chapters: Int?
    var url: String
    var background: String?
    var sypnosis: String?
    var themes: [Theme]
    var genres: [Genre]
    var demographics: [Demographic]
    var authors: [Author]
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case titleJapanese
        case titleEnglish
        case mainPicture
        case status
        case startDate
        case endDate
        case score
        case volumes
        case chapters
        case url
        case background
        case sypnosis
        case themes
        case genres
        case demographics
        case authors
    }
}

extension Manga {
    var formattedAuthors: String {
        self.authors.map{$0.formattedString}.formatted(.list(type: .and))
    }
    
    var formattedGenres: String {
        self.genres.map{$0.genre}.formatted(.list(type: .and))
    }
    
    var formattedDemographics: String {
        self.demographics.map { $0.demographic }.formatted(.list(type: .and))
    }
}
