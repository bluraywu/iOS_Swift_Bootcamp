//
// Created by Ray WU on 28/05/2022.
//

import Foundation

struct Result: Codable {
    let hits: [Post]
}

struct Post: Codable, Identifiable {
    var id: String {
        objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}
