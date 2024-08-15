//
//  HomeBannerCollectionViewCell.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/08/01.
//

import UIKit
import Kingfisher

struct HomeBannerCollectionViewCellViewModel: Hashable {
    let bannerImage: String
}

final class HomeBannerCollectionViewCell: UICollectionViewCell {
    static let reusableId: String = "HomeBannerCollectionViewCell"
    
    @IBOutlet private weak var imageView: UIImageView!
    
    func setViewModel(_ viewModel: HomeBannerCollectionViewCellViewModel) {
        imageView.kf.setImage(with: URL(string: viewModel.bannerImage))
    }
}

extension HomeBannerCollectionViewCell {
    static func bannerLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0), // 그룹 Width의 100%
            heightDimension: .fractionalHeight(1.0) // 그룹 Height의 100%
        )
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0), // 컬렉션 뷰 Width의 100%
            heightDimension: .fractionalWidth(165/393) // Height는 디자인상 Width 대비 비율
        )
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
