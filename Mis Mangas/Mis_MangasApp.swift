//
//  Mis_MangasApp.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 5/9/24.
//

import SwiftUI

@main
struct Mis_MangasApp: App {
    @State var vm: MangasViewModel = MangasViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environment(vm)
            }
        }
    }
}
