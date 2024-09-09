//
//  Author.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 5/9/24.
//

import Foundation

struct Author: Decodable {
    var id: String
    var firstName: String?
    var lastName: String?
    var role: String
    
    enum CodingKeys: CodingKey {
        case id
        case firstName
        case lastName
        case role
    }
}

extension Author {
    var formattedString: String {
        return "\(firstName ?? "") \(lastName ?? "") (\(role))"
    }
}
