//
//  HomeViewModel.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/08/01.
//

import Foundation
import Combine

final class HomeViewModel {
    final class State {
        struct CollectionViewModels {
            var bannerViewModels: [HomeBannerCollectionViewCellViewModel]?
            var horizontalProductViewModels: [HomeProductCollectionViewCellViewModel]?
            var verticalProductViewModels: [HomeProductCollectionViewCellViewModel]?
            var couponState: [HomeCouponButtonCollectionViewCellViewModel]?
            var separateLine1ViewModels: [HomeSeparateLineCollectionViewCellViewModel] = [HomeSeparateLineCollectionViewCellViewModel()]
            var separateLine2ViewModels: [HomeSeparateLineCollectionViewCellViewModel] = [HomeSeparateLineCollectionViewCellViewModel()]
            var themeViewModels: (headerViewModel: HomeThemeHeaderCollectionReusableViewModel, item:  [HomeThemeCollectionViewCellViewModel])?
            
        }
        @Published var collectionViewModels: CollectionViewModels = CollectionViewModels()
    }
    private(set) var state: State = State()
    private var loadDataTask: Task<Void, Never>?
    private let couponDownloadedKey: String = "CouponDownloaded"
    
    enum Action {
        case loadData
        case loadCoupon
        case getDataSuccess(HomeResponse)
        case getDataFailure(Error)
        case getCouponSuccess(Bool)
        case didTapCouponButton
    }
    
    func process(action: Action) {
        switch action {
        case .loadData:
            loadData()
        case .loadCoupon:
            loadCoupon()
        case .getDataSuccess(let response):
            transformResponse(response)
        case .getDataFailure(let error):
            print("Network Error: \(error)")
        case .getCouponSuccess(let isDownloaded):
            Task {
                await transformCoupon(isDownloaded)
            }
        case .didTapCouponButton:
            downloadCoupon()
        }
    }
    
    deinit {
        loadDataTask?.cancel()
    }
}


/// MVI 생명 주기와 관련 없는 코드
extension HomeViewModel {
    private func loadData() {
        loadDataTask = Task {
            do {
                let response = try await NetworkService.shared.getHomeData()
                process(action: .getDataSuccess(response))
            } catch {
                process(action: .getDataFailure(error))
            }
        }
    }
    
    private func loadCoupon() {
        let couponState: Bool = UserDefaults.standard.bool(forKey: couponDownloadedKey)
        process(action: .getCouponSuccess(couponState))
    }
    
    private func transformResponse(_ response: HomeResponse) {
        Task { await transformBanner(response) }
        Task { await transformHorizontalProduct(response) }
        Task { await transformVerticalProduct(response) }
        Task { await transformTheme(response) }
    }
    
    @MainActor
    private func transformBanner(_ response: HomeResponse) async {
        state.collectionViewModels.bannerViewModels = response.banners.map { banner in
            HomeBannerCollectionViewCellViewModel(bannerImage: banner.imageUrl)
        }
    }
    
    @MainActor
    private func transformHorizontalProduct(_ response: HomeResponse) async {
        state.collectionViewModels.horizontalProductViewModels = productToHomeProductCollectionViewCellViewModel(response.horizontalProducts)
    }
    
    @MainActor
    private func transformVerticalProduct(_ response: HomeResponse) async {
        state.collectionViewModels.verticalProductViewModels = productToHomeProductCollectionViewCellViewModel(response.verticalProducts)
    }
    
    private func productToHomeProductCollectionViewCellViewModel(_ product: [Product]) -> [HomeProductCollectionViewCellViewModel] {
        return product.map { homeProductResponse in
            HomeProductCollectionViewCellViewModel(
                imageUrlString: homeProductResponse.imageUrl,
                title: homeProductResponse.title,
                reasonsDiscountString: homeProductResponse.discount,
                originalPrice: "\(homeProductResponse.originalPrice.moneyString)",
                discountPrice: "\(homeProductResponse.discountPrice.moneyString)")
        }
    }
    
    @MainActor
    private func transformCoupon(_ isDownloaded: Bool) async {
        state.collectionViewModels.couponState = [.init(state: isDownloaded ? .disable : .enable)]
    }
    
    private func downloadCoupon() {
        UserDefaults.standard.setValue(true, forKey: couponDownloadedKey)
        process(action: .loadCoupon)
    }
    
    @MainActor
    private func transformTheme(_ response: HomeResponse) async {
        let items = response.themes.map { theme in
            HomeThemeCollectionViewCellViewModel(themeImageUrl: theme.imageUrl)
        }
        state.collectionViewModels.themeViewModels = (HomeThemeHeaderCollectionReusableViewModel(headerText: "테마관"), items)
    }
}
