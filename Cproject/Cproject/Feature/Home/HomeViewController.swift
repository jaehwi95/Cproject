//
//  HomeViewController.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/07/31.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
    
    private enum Section: Int {
        case banner
        case horizontalProductItem
        case separateLine1
        case couponButton
        case verticalProductItem
        case separateLine2
        case theme
    }
    @IBOutlet private weak var collectionView: UICollectionView!
    private lazy var dataSource: DataSource = setDataSource()
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = setCompositionalLayout()
    private var viewModel: HomeViewModel = HomeViewModel()
    private var cancellable: Set<AnyCancellable> = []
    private var currentSection: [Section] {
        dataSource.snapshot().sectionIdentifiers as [Section]
    }
    private var didTapCouponDownload: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingViewModel()
        collectionView.delegate = self
        collectionView.collectionViewLayout = compositionalLayout
        
        viewModel.process(action: .loadData)
        viewModel.process(action: .loadCoupon)
    }
    
    private func setCompositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] section, _ in
            switch self?.currentSection[section] {
            case .banner:
                return HomeBannerCollectionViewCell.bannerLayout()
            case .horizontalProductItem:
                return HomeProductCollectionViewCell.horizontalProductItemLayout()
            case .separateLine1, .separateLine2:
                return HomeSeparateLineCollectionViewCell.separateLineLayout()
            case .couponButton:
                return HomeCouponButtonCollectionViewCell.couponButtonItemLayout()
            case .verticalProductItem:
                return HomeProductCollectionViewCell.verticalProductItemLayout()
            case .theme:
                return HomeThemeCollectionViewCell.themeLayout()
            case .none:
                return nil
            }
        }
    }
    
    private func bindingViewModel() {
        viewModel.state.$collectionViewModels.receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applySnapShot()
            }.store(in: &cancellable)
        
        didTapCouponDownload.receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.viewModel.process(action: .didTapCouponButton)
            }.store(in: &cancellable)
    }
    
    private func setDataSource() -> DataSource {
        let dataSource: DataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { [weak self] collectionView, indexPath, viewModel in
                switch self?.currentSection[indexPath.section] {
                case .banner:
                    return self?.bannerCell(collectionView, indexPath, viewModel)
                case .horizontalProductItem, .verticalProductItem:
                    return self?.productItemCell(collectionView, indexPath, viewModel)
                case .separateLine1, .separateLine2:
                    return self?.separateLineCell(collectionView, indexPath, viewModel)
                case .couponButton:
                    return self?.couponButtonCell(collectionView, indexPath, viewModel)
                case .theme:
                    return self?.themeCell(collectionView, indexPath, viewModel)
                case .none:
                    return .init()
                }
            }
        )
        
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader,
                  let viewModel = self?.viewModel.state.collectionViewModels.themeViewModels?.headerViewModel else {
                return nil
            }
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeThemeHeaderCollectionReusableView.reusableId,
                for: indexPath) as? HomeThemeHeaderCollectionReusableView
            headerView?.setViewModel(viewModel)
            return headerView
        }
        
        return dataSource
    }
    
    private func applySnapShot() {
        var snapShot: SnapShot = SnapShot()
        
        if let bannerViewModels = viewModel.state.collectionViewModels.bannerViewModels {
            snapShot.appendSections([.banner])
            snapShot.appendItems(bannerViewModels, toSection: .banner)
        }
        
        if let horizontalProductViewModels = viewModel.state.collectionViewModels.horizontalProductViewModels {
            snapShot.appendSections([.horizontalProductItem])
            snapShot.appendItems(horizontalProductViewModels, toSection: .horizontalProductItem)
            
            snapShot.appendSections([.separateLine1])
            snapShot.appendItems(viewModel.state.collectionViewModels.separateLine1ViewModels, toSection: .separateLine1)
        }
        
        if let couponViewModels = viewModel.state.collectionViewModels.couponState {
            snapShot.appendSections([.couponButton])
            snapShot.appendItems(couponViewModels, toSection: .couponButton)
        }
        
        if let verticalProductViewModels = viewModel.state.collectionViewModels.verticalProductViewModels {
            snapShot.appendSections([.verticalProductItem])
            snapShot.appendItems(verticalProductViewModels, toSection: .verticalProductItem)
        }
        
        if let themeViewModels = viewModel.state.collectionViewModels.themeViewModels?.item {
            snapShot.appendSections([.separateLine2])
            snapShot.appendItems(viewModel.state.collectionViewModels.separateLine1ViewModels, toSection: .separateLine2)
            
            snapShot.appendSections([.theme])
            snapShot.appendItems(themeViewModels, toSection: .theme)
        }
        
        dataSource.apply(snapShot)
    }
    
    private func bannerCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeBannerCollectionViewCellViewModel,
              let cell: HomeBannerCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeBannerCollectionViewCell.reusableId,
                for: indexPath
              ) as? HomeBannerCollectionViewCell else {
            return .init()
        }
        cell.setViewModel(viewModel)
        return cell
    }
    
    private func productItemCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeProductCollectionViewCellViewModel,
              let cell: HomeProductCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeProductCollectionViewCell.reusableId,
                for: indexPath
              ) as? HomeProductCollectionViewCell else {
            return .init()
        }
        cell.setViewModel(viewModel)
        return cell
    }
    
    private func couponButtonCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeCouponButtonCollectionViewCellViewModel,
              let cell: HomeCouponButtonCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeCouponButtonCollectionViewCell.reusableId,
                for: indexPath
              ) as? HomeCouponButtonCollectionViewCell else {
            return .init()
        }
        cell.setViewModel(viewModel, didTapCouponDownload)
        return cell
    }
    
    private func separateLineCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeSeparateLineCollectionViewCellViewModel,
              let cell: HomeSeparateLineCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeSeparateLineCollectionViewCell.reusableId,
                for: indexPath
              ) as? HomeSeparateLineCollectionViewCell else {
            return .init()
        }
        cell.setViewModel(viewModel)
        return cell
    }
    
    private func themeCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeThemeCollectionViewCellViewModel,
              let cell: HomeThemeCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeThemeCollectionViewCell.reusableId,
                for: indexPath
              ) as? HomeThemeCollectionViewCell else {
            return .init()
        }
        cell.setViewModel(viewModel)
        return cell
    }
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        let favoriteStoryboard: UIStoryboard = UIStoryboard(name: "Favorite", bundle: nil)
        if let favoriteViewController = favoriteStoryboard.instantiateInitialViewController() {
            navigationController?.pushViewController(favoriteViewController, animated: true)
        }
    }
    
    
    /*
     func createLayout() -> UICollectionViewLayout {
     let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
     // 아이템의 크기 정의
     let itemSize = NSCollectionLayoutSize(
     widthDimension: .fractionalWidth(1.0), // 그룹 Width의 100%
     heightDimension: .fractionalHeight(1.0) // 그룹 Height의 100%
     )
     let item = NSCollectionLayoutItem(layoutSize: itemSize)
     
     // 그룹의 크기 정의
     let groupSize = NSCollectionLayoutSize(
     widthDimension: .fractionalWidth(1.0), // 컬렉션 뷰 Width의 100%
     heightDimension: .absolute(50) // Height는 50pt
     )
     // 해당 사이즈로 Horizontal 그룹 생성
     let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
     
     // 지정된 그룹으로 섹션 생성
     let section = NSCollectionLayoutSection(group: group)
     // 그룹 간 간격
     section.interGroupSpacing = 10
     // 섹션 여백 설정
     section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10)
     return section
     }
     return layout
     }
     */
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch currentSection[indexPath.section] {
        case .horizontalProductItem, .verticalProductItem:
            let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
            guard let viewController: UIViewController = storyboard.instantiateInitialViewController() else {
                return
            }
            navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
}

//#Preview {
//    UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController() as! HomeViewController
//}
