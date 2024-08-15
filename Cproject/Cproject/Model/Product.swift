//
//  Product.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/08/02.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let imageUrl: String
    let title: String
    let discount: String
    let originalPrice: Int
    let discountPrice: Int
}
