//
//  SearchHelper.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 16/9/24.
//

import Foundation
import Combine

final class SearchHelper: ObservableObject {
    let interactor: DataInteractor
    
    @Published var searchText: String = ""
    @Published var debounceText: String = ""
    @Published var selectedTokens: [SearchTokenEnum] = []
    @Published var searchSuggestions:[String] = SearchTokenEnum.filtered
    @Published var isSearching: Bool = false {
        didSet {
            print(isSearching)
        }
    }
    
    var authors: [String] = []
    var demographics: [String] = []
    var genres: [String] = []
    var themes: [String] = []
    
    private var subscriptions = Set<AnyCancellable>()

    init(interactor: DataInteractor = Network.shared) {
        self.interactor = interactor
        $searchText
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .sink { [weak self] value in
                self?.debounceText = value
                self?.manageSearchCompletion()
            }
            .store(in: &subscriptions)
        $selectedTokens
            .sink { [weak self] tokens in
                self?.manageSearchSuggestions(tokens)
            }.store(in: &subscriptions)
        
        Task {
            await getAuthors()
            await getDemographics()
            await getGenres()
            await getThemes()
        }
    }
    
    private func manageSearchCompletion() {
        if let lasToken = selectedTokens.last, searchSuggestions.isEmpty, isSearching {
            if case .author = lasToken {
                searchSuggestions = authors.filter { $0.lowercased().contains(searchText.lowercased()) }
            }
            if case .demographic = lasToken {
                searchSuggestions = demographics.filter { $0.lowercased().contains(searchText.lowercased()) }
            }
            if case .genre = lasToken {
                searchSuggestions = genres.filter { $0.lowercased().contains(searchText.lowercased()) }
            }
            if case .theme = lasToken {
                searchSuggestions = themes.filter { $0.lowercased().contains(searchText.lowercased()) }
            }
        } else if !searchText.isEmpty {
            searchSuggestions = []
        }
    }
    
    private func manageSearchSuggestions(_ tokens: [SearchTokenEnum]) {
        if let lastToken = tokens.last, searchText.isEmpty, isSearching {
            if case .title = lastToken {
                searchSuggestions = [
                    SearchTokenEnum.beginWith.rawValue,
                    SearchTokenEnum.contains.rawValue
                ]
            } else {
                searchSuggestions = []

            }
        } else if isSearching && searchText.isEmpty && selectedTokens.isEmpty {
            searchSuggestions = SearchTokenEnum.filtered
        }
    }
    
    
    
    func reset() {
        selectedTokens = .init()
        searchSuggestions = SearchTokenEnum.filtered
    }
    
    private func getAuthors() async {
        do {
             let authors = try await interactor.fetchAuthors()
            await MainActor.run {
                self.authors = Set(authors.compactMap{$0.lastName}).sorted()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getDemographics() async {
        do {
             let demographics = try await interactor.fetchDemographics()
            await MainActor.run {
                self.demographics = demographics
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getGenres() async {
        do {
             let genres = try await interactor.fetchGenres()
            await MainActor.run {
                self.genres = genres
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getThemes() async {
        do {
             let themes = try await interactor.fetchThemes()
            await MainActor.run {
                self.themes = themes
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
