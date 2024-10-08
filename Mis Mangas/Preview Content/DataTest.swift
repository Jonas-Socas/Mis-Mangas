//
//  DataTest.swift
//  Mis Mangas
//
//  Created by Jonás Socas on 5/9/24.
//

import Foundation

struct DataTest: DataInteractor {
    func fetchPaginatedMangas(query: String = .empty, url: URL = URL.getMangas, page: Int, limit: Int) async throws -> PaginatedResponse<Manga> {
        let url = Bundle.main.url(forResource: "mangas", withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(PaginatedResponse<Manga>.self, from: data)
    }
    
    func fetchMangas(query: String = .empty, url: URL = URL.getMangas) async throws -> [Manga] {
        let url = Bundle.main.url(forResource: "mangas_search", withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Manga].self, from: data)
    }
    
    func fetchPaginatedMangas(url: URL = URL.getMangas, page: Int, limit: Int) async throws -> PaginatedResponse<Manga> {
        let url = Bundle.main.url(forResource: "mangas", withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(PaginatedResponse<Manga>.self, from: data)
    }
    
    func fetchMangas(url: URL = URL.getMangas) async throws -> [Manga] {
        let url = Bundle.main.url(forResource: "mangas_search", withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Manga].self, from: data)
    }
    
    func fetchAuthors() async throws -> [Author] {
        let url = Bundle.main.url(forResource: "authors", withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Author].self, from: data)
    }
    
    func fetchDemographics() async throws -> [String] {
        let url = Bundle.main.url(forResource: "demographics", withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([String].self, from: data)
    }
    
    func fetchGenres() async throws -> [String] {
        let url = Bundle.main.url(forResource: "genres", withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([String].self, from: data)
    }
    
    func fetchThemes() async throws -> [String] {
        let url = Bundle.main.url(forResource: "themes", withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([String].self, from: data)
    }
    
    func getMangaByID(id: Int) async throws -> Manga? {
        Manga.preview
    }
}

extension Manga {
    static var preview: Manga {
        Manga(
            id: 1,
            title: "Monster",
            titleJapanese: "MONSTER",
            titleEnglish: "Monster",
            mainPicture: "\"https://cdn.myanimelist.net/images/manga/3/258224l.jpg\"",
            status: "finished",
            startDate: "1994-12-05T00:00:00Z",
            endDate: "2001-12-20T00:00:00Z",
            score: 9.15,
            volumes: 18,
            chapters: 162,
            url: "\"https://myanimelist.net/manga/1/Monster\"",
            background: "Monster won the Grand Prize at the 3rd annual Tezuka Osamu Cultural Prize in 1999, as well as the 46th Shogakukan Manga Award in the General category in 2000. The series was published in English by VIZ Media under the VIZ Signature imprint from February 21, 2006 to December 16, 2008, and again in 2-in-1 omnibuses (subtitled The Perfect Edition) from July 15, 2014 to July 19, 2016. The manga was also published in Brazilian Portuguese by Panini Comics/Planet Manga from June 2012 to April 2015, in Polish by Hanami from March 2014 to February 2017, in Spain by Planeta Cómic from June 16, 2009 to September 21, 2010, and in Argentina by LARP Editores.",
            sypnosis: "Kenzou Tenma, a renowned Japanese neurosurgeon working in post-war Germany, faces a difficult choice: to operate on Johan Liebert, an orphan boy on the verge of death, or on the mayor of Düsseldorf. In the end, Tenma decides to gamble his reputation by saving Johan, effectively leaving the mayor for dead.\n\nAs a consequence of his actions, hospital director Heinemann strips Tenma of his position, and Heinemann's daughter Eva breaks off their engagement. Disgraced and shunned by his colleagues, Tenma loses all hope of a successful career—that is, until the mysterious killing of Heinemann gives him another chance.\n\nNine years later, Tenma is the head of the surgical department and close to becoming the director himself. Although all seems well for him at first, he soon becomes entangled in a chain of gruesome murders that have taken place throughout Germany. The culprit is a monster—the same one that Tenma saved on that fateful day nine years ago.\n\n[Written by MAL Rewrite]",
            themes: [Theme(id: "4394C99F-615B-494A-929E-356A342A95B8", theme: "Psychological"), Theme(id: "840867E7-6C60-49CE-8C47-A99AA71A2113", theme: "Adult Cast")],
            genres: [Genre(id: "4C13067F-96FF-4F14-A1C0-B33215F24E0B", genre: "Award Winning"), Genre(id: "4312867C-1359-494A-AC46-BADFD2E1D4CD", genre: "Drama"), Genre(id: "97C8609D-856C-419E-A4ED-E13A5C292663", genre: "Mystery")],
            demographics: [ Demographic(id: "CE425E7E-C7CD-42DB-ADE3-1AB9AD16386D", demographic: "Seinen")],
            authors: [ Author(id: "54BE174C-2FE9-42C8-A842-85D291A6AEDD", firstName: "Naoki", lastName: "Urasawa", role: "Story & Art")]
        )
    }
}
