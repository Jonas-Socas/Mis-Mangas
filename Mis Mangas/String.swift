//
//  Strubg.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 6/9/24.
//

import Foundation

extension String {
    var url: URL? {
        URL(string: self.replacingOccurrences(of: "\"", with: ""))
    }
    
    static let empty: String =  ""
    
}
