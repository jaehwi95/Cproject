//
//  FavoriteViewModel.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/08/02.
//

import Foundation

final class FavoriteViewModel {
    final class State {
        @Published var tableViewModel: [FavoriteItemTableViewCellViewModel]?
    }
    private(set) var state: State = State()
    private var loadDataTask: Task<Void, Never>?
    
    enum Action {
        case getFavoriteAPI
        case getFavoriteSuccess(FavoritesResponse)
        case getFavoriteFailure(Error)
        case didTapPurchase
    }
    
    func process(_ action: Action) {
        switch action {
        case .getFavoriteAPI:
            getFavoriteFromAPI()
        case .getFavoriteSuccess(let favoritesResponse):
            translateFavoriteItemViewModel(favoritesResponse)
        case .getFavoriteFailure(let error):
            print(error)
        case .didTapPurchase:
            break
        }
    }
    
    deinit {
        loadDataTask?.cancel()
    }
}

extension FavoriteViewModel {
    private func getFavoriteFromAPI() {
        loadDataTask = Task {
            do {
                let response = try await NetworkService.shared.getFavoriteData()
                process(.getFavoriteSuccess(response))
            } catch {
                process(.getFavoriteFailure(error))
            }
        }
    }
    
    private func translateFavoriteItemViewModel(_ response: FavoritesResponse) {
        state.tableViewModel = response.favorites.map { favorite in
            FavoriteItemTableViewCellViewModel(
                imageUrl: favorite.imageUrl,
                productName: favorite.title,
                productPrice: favorite.discountPrice.moneyString)
        }
    }
}
