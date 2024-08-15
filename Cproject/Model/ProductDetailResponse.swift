//
//  ProductDetailResponse.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/08/05.
//

import Foundation

struct ProductDetailResponse: Codable {
    let bannerImages: [String]
    let product: ProductDetail
    let option: ProductDetailOption
    let detailImages: [String]
}

struct ProductDetailOption: Codable {
    let type, name: String
    let image: String
}

struct ProductDetail: Codable {
    let name: String
    let discountPercent, originalPrice, discountPrice, rate: Int
}
