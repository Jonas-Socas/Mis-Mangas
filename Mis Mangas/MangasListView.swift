//
//  MangasListView.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 10/9/24.
//

import SwiftUI

struct MangasListView: View {
    @Environment(MangasViewModel.self) var vm
    @State private var page = 1
    @State private var limit = 10
    @State private var imageVM = ImageVM()
    
    var body: some View {
        ZStack{
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
            Button("Load More", action: loadMore)
                .buttonStyle(.borderedProminent)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
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
    MangasListView()
        .environment(MangasViewModel(interactor: DataTest()))
}
