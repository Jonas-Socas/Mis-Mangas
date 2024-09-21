//
//  ContentView.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 5/9/24.
//

import SwiftUI

struct ContentView: View {
    @State var vm: MangasViewModel = MangasViewModel()
    var body: some View{
        TabView {
            MangasView()
                .environment(vm)
                .tabItem { Label("Manga db", systemImage: "list.bullet.rectangle.portrait") }
            MangasMyCollectionView()
                .environment(vm)
                .tabItem { Label("My Collection", systemImage: "person.fill") }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
