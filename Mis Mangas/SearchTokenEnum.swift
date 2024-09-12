//
//  SearchTokenEnum.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 11/9/24.
//

import Foundation

enum SearchTokenEnum: String, CaseIterable, Identifiable {
    case author = "Author"
    case genre = "Genre"
    case beginWith = "Begin With"
    case containsIn = "Contains"
    
    var id: String { rawValue }
    
    var displayText: String {
        return rawValue
    }
}
