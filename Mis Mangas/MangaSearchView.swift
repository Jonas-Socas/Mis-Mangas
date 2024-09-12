//
//  MangaSearchView().swift
//  Mis Mangas
//
//  Created by Jonás Socas on 10/9/24.
//

import SwiftUI

struct MangaSearchView: View {
    @State private var searchQuery = ""
    @State private var selectedSearchType: SearchType = .beginsWith
    @State private var hasAppeared: Bool = false
    
    @Environment(MangasViewModel.self) var vm

    var body: some View {
        VStack {
            // Campo de texto para la búsqueda
            TextField("Enter search term", text: $searchQuery)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            // Selector de búsqueda por "begins with" o "contains"
            Picker("Search Type", selection: $selectedSearchType) {
                Text("Begins With").tag(SearchType.beginsWith)
                Text("Contains").tag(SearchType.contains)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // Botón para iniciar la búsqueda
            Button {
                searchManga(query: searchQuery, searchType: selectedSearchType)
            } label: {
                Text("Search")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.bottom)
            
            Group {
                if vm.isLoading {
                    ProgressView("Searching...")
                        .padding()
                } else if !vm.errorMsg.isEmpty {
                    Text("Error: \(vm.errorMsg)")
                        .foregroundColor(.red)
                        .padding()
                } else if vm.mangas.isEmpty {
                    Text("No results found")
                        .padding()
                } else {
                    List(vm.mangas, id: \.id) { manga in
                        NavigationLink(destination: MangaDetailView(manga: manga)) {
                            MangaCellView(manga: manga)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        }
        .onAppear {
            if !hasAppeared {
                vm.reset()
                hasAppeared.toggle()
            }
        }
        .padding()
    }
    
    // Función para realizar la búsqueda
    private func searchManga(query: String, searchType: SearchType) {
        Task {
            await vm.searchManga(query: query, searchType: searchType)
        }
    }
}

#Preview {
    MangaSearchView()
        .environment(MangasViewModel(interactor: DataTest()))
}
