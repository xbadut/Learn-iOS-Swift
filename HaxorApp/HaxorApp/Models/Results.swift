//
//  Results.swift
//  HaxorApp
//
//  Created by Rizal Fahrudin on 28/09/21.
//

import Foundation


struct Results: Decodable {
    let hits: [Posts]
}

struct Posts: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    let points: Int
    let objectID: String
    let url: String?
    let title: String
}
