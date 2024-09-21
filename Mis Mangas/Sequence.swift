//
//  Sequence.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 21/9/24.
//

import Foundation

extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T?
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            if let transformedValue = try await transform(element) {
                values.append(transformedValue)
            }
        }
        return values
    }
}
