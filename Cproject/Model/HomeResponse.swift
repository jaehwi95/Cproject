//
//  HomeResponse.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/08/01.
//

import Foundation

struct HomeResponse: Decodable {
    let banners: [Banner]
    let horizontalProducts: [Product]
    let verticalProducts: [Product]
    let themes: [Banner]
}

struct Banner: Decodable {
    let id: Int
    let imageUrl: String
}
