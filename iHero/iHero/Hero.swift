//
//  Hero.swift
//  iHero
//
//  Created by Stephanie Ballard on 4/7/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let results: [Hero]
}
// hashable making sure nothing isn't unique, to use diffable things need to be unique

struct Hero: Codable, Hashable {
    static func == (lhs: Hero, rhs: Hero) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        
    }
    
    let id: String
    let name: String
    let image: Image
}

struct Image: Codable {
    let url: String
}
