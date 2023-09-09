//
//  Pokemon.swift
//  Pokedex-Masters
//
//  Created by Doni on 9/9/23.
//
import Foundation

struct Pokemon: Codable, Identifiable {
    var id: Int
    let name: String
    let isDefault: Bool
    let weigth: Int
    let height: Int
    let baseExperience: Int
    let locationAreaEncounters: String
    let order: Int
    let abilities: [Ability]
    let species: Info
    let forms: [Info]
    let gameIndices: [GameIndex]
    let moves: [Move]
    let sprites: [Sprites]
}

struct Ability: Codable {
    let ability: Info
    let isHidden: Bool
    let slot: Int
}

struct GameIndex: Codable {
    let gameIndex: Int
    let version: Info
}

struct Sprites: Codable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    let other: Other
}

struct Other: Codable {
    let officialArtwork: OfficialArtwork
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable {
    let frontDefault, frontShiny: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

struct Move: Codable {
    let move: Info
    let versionGroupDetails: [VersionGroupDetail]
}

struct VersionGroupDetail: Codable {
    let levelLearnedAt: Int
    let moveLearnMethod, versionGroup: Info
}

struct Stat: Codable {
    let baseStat, effort: Int
    let stat: Info
}

struct Info: Codable {
    let name: String
    let url: String
}

