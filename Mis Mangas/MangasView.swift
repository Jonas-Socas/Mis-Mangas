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
        NavigationStack{
            MangasListView(searchHelper: searchHelper)
                .overlay(content: {
                    if vm.isLoading { ProgressView() }
                })
                .navigationTitle("List of Mangas")
                .task {
                    await vm.getAllMangas()
                }
                .searchable(text: $searchHelper.searchText, tokens: $searchHelper.selectedTokens, prompt: "Search by title, author, genre...") { token in
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
}

#Preview {
    NavigationStack {
        MangasView()
            .environment(MangasViewModel(interactor: DataTest()))
    }
}
