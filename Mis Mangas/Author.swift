//
//  Author.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 5/9/24.
//

import Foundation

struct Author: Decodable {
    var id: String
    var firstname: String?
    var lastname: String?
    var role: String
}
