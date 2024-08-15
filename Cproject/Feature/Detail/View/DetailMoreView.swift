//
//  DetailMoreView.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/08/06.
//

import SwiftUI

final class DetailMoreViewModel: ObservableObject {
    
}

struct DetailMoreView: View {
    @ObservedObject var viewModel: DetailMoreViewModel
    var onMoreTapped: () -> Void
    
    var body: some View {
        Button(
            action: {
                onMoreTapped()
            },
            label: {
                HStack(alignment: .center, spacing: 10) {
                    Text("상품 정보 더 보기")
                        .font(CPFont.SwiftUI.bold17)
                        .foregroundStyle(CPColor.SwiftUI.blue)
                    CPImage.SwiftUI.down
                        .foregroundStyle(CPColor.SwiftUI.grayIcon)
                }
                .frame(maxWidth: .infinity, minHeight: 40)
                .border(CPColor.SwiftUI.blue, width: 1)
            }
        )
    }
}

#Preview {
    DetailMoreView(
        viewModel: DetailMoreViewModel(),
        onMoreTapped: {}
    )
}
