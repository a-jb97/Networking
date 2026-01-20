//
//  Picsum.swift
//  Networking
//
//  Created by 전민돌 on 1/20/26.
//

import Foundation

struct Picsum: Decodable {
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
}
