//
//  Category.swift
//  TodoEuyApp
//
//  Created by Rizal Fahrudin on 06/10/21.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    var items = List<Item>()
}
