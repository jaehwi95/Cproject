//
//  DetailPurchaseView.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/08/06.
//

import SwiftUI

final class DetailPurchaseViewModel: ObservableObject {
    @Published var isFavorite: Bool
    
    init(isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
}

struct DetailPurchaseView: View {
    @ObservedObject var viewModel: DetailPurchaseViewModel
    var onFavoriteTapped: () -> Void
    var onPurchaseTapped: () -> Void
    
    var body: some View {
        HStack(spacing: 30) {
            Button(
                action: {
                    onFavoriteTapped()
                },
                label: {
                    viewModel.isFavorite ? CPImage.SwiftUI.favoriteOn : CPImage.SwiftUI.favoriteOff
                }
            )
            Button(
                action: {
                    onPurchaseTapped()
                },
                label: {
                    Text("구매 하기")
                        .font(CPFont.SwiftUI.medium16)
                        .foregroundStyle(CPColor.SwiftUI.white)
                        .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                        .background(CPColor.SwiftUI.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            )
        }
        .padding(.top, 10)
        .padding(.horizontal, 25)
    }
}

#Preview {
    DetailPurchaseView(
        viewModel: DetailPurchaseViewModel(isFavorite: true),
        onFavoriteTapped: {},
        onPurchaseTapped: {}
    )
}
