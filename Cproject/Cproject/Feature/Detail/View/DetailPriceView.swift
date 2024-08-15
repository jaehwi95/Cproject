//
//  DetailPriceView.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/08/06.
//

import SwiftUI

final class DetailPriceViewModel: ObservableObject {
    @Published var discountRate: String
    @Published var originalPrice: String
    @Published var currentPrice: String
    @Published var shippingType: String
    
    init(discountRate: String, originalPrice: String, currentPrice: String, shippingType: String) {
        self.discountRate = discountRate
        self.originalPrice = originalPrice
        self.currentPrice = currentPrice
        self.shippingType = shippingType
    }
}

struct DetailPriceView: View {
    @ObservedObject var viewModel: DetailPriceViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 21) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 0) {
                    Text(viewModel.discountRate)
                        .font(CPFont.SwiftUI.bold14)
                        .foregroundStyle(CPColor.SwiftUI.grayIcon)
                    Text(viewModel.originalPrice)
                        .font(CPFont.SwiftUI.bold16)
                        .foregroundStyle(CPColor.SwiftUI.gray5)
                        .strikethrough()
                }
                Text(viewModel.currentPrice)
                    .font(CPFont.SwiftUI.bold20)
                    .foregroundStyle(CPColor.SwiftUI.red)
            }
            Text(viewModel.shippingType)
                .font(CPFont.SwiftUI.regular12)
                .foregroundStyle(CPColor.SwiftUI.grayIcon)
        }
    }
}

#Preview {
    DetailPriceView(viewModel: DetailPriceViewModel(
        discountRate: "53%",
        originalPrice: "300,000원",
        currentPrice: "139,000원",
        shippingType: "무료배달"
    ))
}
