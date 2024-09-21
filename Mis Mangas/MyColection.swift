//
//  MyColection.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 21/9/24.
//

import Foundation
import SwiftData

@Model
final class MangaInMyCollection {
    @Attribute(.unique) var id: UUID
    var mangaID: Int
    var totalVolumes: Int
    var purchasedVolumes: Int
    var currentVolumeReading: Int
    var isComplete: Bool
    
    init(mangaID: Int, totalVolumes: Int, purchasedVolumes: Int, currentVolumeReading: Int, isComplete: Bool) {
        self.id = UUID()
        self.mangaID = mangaID
        self.totalVolumes = totalVolumes
        self.purchasedVolumes = purchasedVolumes
        self.currentVolumeReading = currentVolumeReading
        self.isComplete = isComplete
    }
}
