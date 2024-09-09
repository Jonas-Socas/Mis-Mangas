//
//  ContentView.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 5/9/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(MangasViewModel.self) var vm
    @State private var page = 1
    @State private var limit = 10
    @State private var imageVM = ImageVM()
    
    var body: some View {
        List(vm.mangas, id: \.id) { manga in
            if vm.showAlert {
                Text(vm.errorMsg)
            } else {
                NavigationLink(destination: MangaDetailView(manga: manga)) {
                    MangaCellView(manga: manga)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Listado de Mangas")
        .task {
            await vm.getData(page: page, limit: limit)
        }
    }
    
    private func loadMore() {
        page += 1
        Task {
            await vm.getData(page: page, limit: limit)
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
            .environment(MangasViewModel(interactor: DataTest()))
    }
}
