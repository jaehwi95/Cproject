//
//  DetailViewModel.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/08/05.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    struct State {
        var isError: String?
        var isLoading: Bool = false
        var banners: DetailBannerViewModel?
        var rate: DetailRateViewModel?
        var title: String?
        var option: DetailOptionViewModel?
        var price: DetailPriceViewModel?
        var mainImageUrls: [String]?
        var more: DetailMoreViewModel?
        var purchase: DetailPurchaseViewModel?
    }
    @Published private(set) var state: State = State()
    private(set) var showOptionViewController: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    private(set) var showPurchaseViewController: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    private var loadDataTask: Task<Void, Never>?
    private var isFavorite: Bool = false
    private var needShowMore: Bool = true
    
    enum Action {
        case loadData
        case loading(Bool)
        case getDataSuccess(ProductDetailResponse)
        case getDataFailure(Error)
        case didTapChangeOption
        case didTapMore
        case didTapFavorite
        case didTapPurchase
    }
    
    func process(_ action: Action) {
        switch action {
        case .loadData:
            loadData()
        case .loading(let isLoading):
            Task {
                await toggleLoading(isLoading)
            }
        case .getDataSuccess(let response):
            Task { await transformProductDetailResponse(response) }
        case .getDataFailure(let error):
            Task { await getDataFailure(error) }
        case .didTapChangeOption:
            showOptionViewController.send()
        case .didTapMore:
            Task { await toggleMore() }
        case .didTapFavorite:
            Task { await toggleFavorite() }
        case .didTapPurchase:
            showPurchaseViewController.send()
        }
    }
    
    deinit {
        loadDataTask?.cancel()
    }
}

extension DetailViewModel {
    private func loadData() {
        loadDataTask = Task {
            defer {
                process(.loading(false))
            }
            do {
                process(.loading(true))
                let response = try await NetworkService.shared.getProductDetailData()
                process(.getDataSuccess(response))
            } catch {
                process(.getDataFailure(error))
            }
        }
    }
    
    @MainActor
    private func toggleLoading(_ isLoading: Bool) async {
        state.isLoading = isLoading
    }
    
    @MainActor
    private func toggleFavorite() async {
        isFavorite.toggle()
        state.purchase = DetailPurchaseViewModel(isFavorite: isFavorite)
    }
    
    @MainActor
    private func toggleMore() async {
        needShowMore = false
        state.more = needShowMore ? DetailMoreViewModel() : nil
    }
    
    @MainActor
    private func transformProductDetailResponse(_ response: ProductDetailResponse) async {
        state.isError = nil
        state.banners = DetailBannerViewModel(
            imageUrls: response.bannerImages)
        state.rate = DetailRateViewModel(
            rate: response.product.rate)
        state.title = response.product.name
        state.option = DetailOptionViewModel(
            type: response.option.type,
            name: response.option.name,
            imageUrl: response.option.image)
        state.price = DetailPriceViewModel(
            discountRate: "\(response.product.discountPercent)%",
            originalPrice: response.product.originalPrice.moneyString,
            currentPrice: response.product.discountPrice.moneyString,
            shippingType: "무료배송")
        state.mainImageUrls = response.detailImages
        state.more = needShowMore ? DetailMoreViewModel() : nil
        state.purchase = DetailPurchaseViewModel(isFavorite: isFavorite)
    }
    
    @MainActor
    private func getDataFailure(_ error: Error) {
        state.isError = "Error: \(error.localizedDescription)"
    }
}
