//
//  Mis_MangasApp.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 5/9/24.
//

import SwiftUI
import SwiftData

@main
struct Mis_MangasApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [MangaInMyCollection.self])
    }
}
