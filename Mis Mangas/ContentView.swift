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
        NavigationStack {
            MangasView()
                .environment(vm)
                .tabItem { Image(systemName: "list.bullet.rectangle.portrait") }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
