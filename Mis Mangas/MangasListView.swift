//
//  MangasListView.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 10/9/24.
//

import SwiftUI

struct MangasView: View {
    @Environment(MangasViewModel.self) var vm
    @StateObject private var searchHelper: SearchHelper = .init()
    
    var body: some View {
        MangasListView(searchHelper: searchHelper)
        .navigationTitle("Listado de Mangas")
        .task {
            await vm.getAllMangas()
        }
        .searchable(text: $searchHelper.searchText, tokens: $searchHelper.selectedTokens, prompt: "Buscar por autor, género, temática") { token in
            Text(token.rawValue)
        }
        .searchSuggestions {
            ForEach(searchHelper.searchSuggestions, id: \.self) { searchSuggested in
                if let token = SearchTokenEnum(rawValue: searchSuggested) {
                    Button {
                        searchHelper.selectedTokens.append(token)
                    } label: {
                        Text(
                            searchSuggested
                        )
                    }
                } else {
                    Text(searchSuggested)
                        .searchCompletion(searchSuggested)
                }
            }
        }
        .onChange(of: searchHelper.debounceText) {
            Task {
                if let lastToken = searchHelper.selectedTokens.last {
                    await vm.manageSearch(query:searchHelper.searchText, searchMethod: lastToken)}
            }
        }
    }
    

}

struct MangasListView: View {
    @Environment(MangasViewModel.self) var vm
    @Environment(\.isSearching) var isSearching
    @ObservedObject var searchHelper: SearchHelper
    
    var hideButtons: Bool {
        searchHelper.selectedTokens.contains(.beginWith)
    }
    
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
            HStack {
                Button("Previous", action: previous)
                    .buttonStyle(.borderedProminent)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .opacity(vm.page == 1 ? 0 : 1)
                Button("Next", action: next)
                    .buttonStyle(.borderedProminent)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
            .opacity(hideButtons ? 0 : 1)
            .disabled(hideButtons)
        }
        .onChange(of: isSearching) {
            if !isSearching {
                vm.reset()
                searchHelper.reset()
                Task {
                    await vm.getAllMangas()
                }
            }
            searchHelper.isSearching = isSearching
        }
    }
    
    private func previous() {
        vm.page -= 1
        reload()
    }
    
    private func next() {
        vm.page += 1
        reload()
    }
    
    private func reload() {
        Task {
            if let lastToken = searchHelper.selectedTokens.last, isSearching {
                await vm.manageSearch(query: searchHelper.searchText, searchMethod: lastToken)
            } else {
                await vm.getAllMangas()
            }
        }
    }
}
#Preview {
    NavigationStack {
        MangasView()
            .environment(MangasViewModel(interactor: DataTest()))
    }
}
