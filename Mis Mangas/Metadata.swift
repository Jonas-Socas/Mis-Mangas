//
//  Metadata.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 5/9/24.
//

import Foundation

struct Metadata: Decodable {
    var total: Int
    var page: Int
    var per: Int
    
    enum CodingKeys: String, CodingKey {
        case total = "total"
        case page = "page"
        case per = "per"
    }
}

extension Metadata {
    var totalPages: Int {
        Int(ceil(Double(total) / Double(per)))
    }
}
