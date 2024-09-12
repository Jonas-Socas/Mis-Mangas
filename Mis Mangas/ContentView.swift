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
            MangasListView()
                .environment(vm)
                .tabItem { Image(systemName: "list.bullet.rectangle.portrait") }
            Text("Colección")
                .tabItem { Image(systemName: "magazine") }
            MangaSearchView()
                .environment(vm)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
