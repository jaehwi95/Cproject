//
//  PurchaseViewModel.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/08/06.
//

import Foundation
import Combine

final class PurchaseViewModel: ObservableObject {
    struct State {
        var purchaseItems: [PurchaseSelectedItemViewModel]?
    }
    @Published private(set) var state: State = State()
    private(set) var showPaymentViewController: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    enum Action {
        case loadData
        case didTapPurchaseButton
    }
    
    func process(_ action: Action) {
        switch action {
        case .loadData:
            Task { await loadData() }
        case .didTapPurchaseButton:
            Task { await didTapPurchaseButton() }
        }
    }
}

extension PurchaseViewModel {
    @MainActor
    private func loadData() async {
        DispatchQueue.main.asyncAfter(deadline: .now()+2) { [weak self] in
            self?.state.purchaseItems = [
                PurchaseSelectedItemViewModel(
                    title: "PlayStation 1",
                    description: "수량 1개 / 무료 배송"
                ),
                PurchaseSelectedItemViewModel(
                    title: "PlayStation 2 PlayStation 2 PlayStation 2",
                    description: "수량 1개 / 무료 배송"
                ),
                PurchaseSelectedItemViewModel(
                    title: "PlayStation 3",
                    description: "수량 1개 / 무료 배송"
                ),
                PurchaseSelectedItemViewModel(
                    title: "PlayStation 4",
                    description: "수량 1개 / 무료 배송"
                ),
                PurchaseSelectedItemViewModel(
                    title: "PlayStation 5",
                    description: "수량 1개 / 무료 배송"
                )
            ]
        }
    }
    
    @MainActor
    private func didTapPurchaseButton() async {
        showPaymentViewController.send()
    }
}
