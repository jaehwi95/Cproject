//
//  HomeSeparateLineCollectionViewCell.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/08/02.
//

import UIKit

struct HomeSeparateLineCollectionViewCellViewModel: Hashable {
    
}

final class HomeSeparateLineCollectionViewCell: UICollectionViewCell {
    static let reusableId: String = "HomeSeparateLineCollectionViewCell"
    
    func setViewModel(_ viewModel: HomeSeparateLineCollectionViewCellViewModel) {
        contentView.backgroundColor = CPColor.UIKit.gray1
    }
}

extension HomeSeparateLineCollectionViewCell {
    static func separateLineLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(11)
        )
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .zero
        section.contentInsets = .init(top: 20, leading: 0, bottom: 0, trailing: 0)
        return section
    }
}
