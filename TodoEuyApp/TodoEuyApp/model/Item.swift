//
//  Item.swift
//  TodoEuyApp
//
//  Created by Rizal Fahrudin on 01/10/21.
//

import Foundation


struct Item: Codable {
    let title: String
    var check: Bool = false
}
