//
//  Shopping.swift
//  Networking
//
//  Created by 전민돌 on 1/21/26.
//

import Foundation

struct Shopping: Decodable {
    let total: Int
    let items: [ShoppingDetail]
}

struct ShoppingDetail: Decodable {
    let title: String
    let image: String
    let lprice: String
    let mallName: String
}
