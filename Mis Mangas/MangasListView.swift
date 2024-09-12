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
    @State private var searchText = ""
    @State private var selectedTokens: [SearchTokenEnum] = []
    @State private var suggestedToken = SearchTokenEnum.allCases
    @State private var searchType: SearchType = .beginsWith
    var body: some View {
        ZStack(alignment: .top) {
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
        .searchable(text: $searchText, tokens: $selectedTokens, prompt: "Buscar por autor, género, temática") { token in
            Text(token.rawValue)
        }
        .searchSuggestions {
            let authorSearchSuggetions: [SearchTokenEnum] = [.beginWith, .containsIn]
            let filteredAllSearchTokenEnum = SearchTokenEnum.allCases.filter { token in
                !selectedTokens.contains(token)
            }
            if !selectedTokens.contains(.author) {
                ForEach(filteredAllSearchTokenEnum) { token in
                    Button {
                        selectedTokens.append(token)
                    } label: {
                        Text(token.rawValue)
                    }
                }
            } else if !selectedTokens.contains(where: {authorSearchSuggetions.contains($0)}) {
                ForEach(authorSearchSuggetions) { token in
                    Button {
                        selectedTokens.append(token)
                    } label: {
                        Text(token.rawValue)
                    }
                }
            }
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
        MangasListView()
            .environment(MangasViewModel(interactor: DataTest()))
    }
}
