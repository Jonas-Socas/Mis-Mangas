//
//  Manga.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 5/9/24.
//

import Foundation

struct Manga: Decodable {
    var id: UInt8
    var title: String
    var titleJapanese: String
    var titleEnglish: String?
    var mainPicture: String
    var status: String
    var startDate: String
    var endDate: String?
    var score: Float
    var volumes: Int?
    var chapters: Int?
    var url: String
    var background: String?
    var sypnosis: String
    var themes: [Theme]
    var genres: [Genre]
    var demographics: [Demographic]
    var authors: [Author]
}
