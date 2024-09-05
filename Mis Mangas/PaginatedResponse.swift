//
//  PaginatedResponse.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 5/9/24.
//

import Foundation

struct PaginatedResponse<T: Decodable>: Decodable {
    var metadata: Metadata
    var items: [Manga]
}
