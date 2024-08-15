//
//  FavoriteViewController.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/08/02.
//

import UIKit
import Combine

final class FavoriteViewController: UIViewController {
    private typealias DataSource = UITableViewDiffableDataSource<Section, AnyHashable>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
    
    private enum Section: Int {
        case favorite
    }
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var dataSource: DataSource = setDataSource()
    private var currentSection: [Section] {
        dataSource.snapshot().sectionIdentifiers as [Section]
    }
    private var viewModel: FavoriteViewModel = FavoriteViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        viewModel.process(.getFavoriteAPI)
    }
    
    private func bindViewModel() {
        viewModel.state.$tableViewModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applySnapShot()
            }.store(in: &cancellables)
    }
    
    private func setDataSource() -> DataSource {
        let dataSource: DataSource = UITableViewDiffableDataSource(
            tableView: tableView) { [weak self] tableView, indexPath, viewModel in
                switch self?.currentSection[indexPath.section] {
                case .favorite:
                    return self?.favoriteCell(tableView, indexPath, viewModel)
                case .none:
                    return .init()
                }
            }
        return dataSource
    }
    
    private func favoriteCell(_ tableView: UITableView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UITableViewCell? {
        guard let viewModel = viewModel as? FavoriteItemTableViewCellViewModel,
              let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteItemTableViewCell.reusableId, for: indexPath) as? FavoriteItemTableViewCell else {
            return nil
        }
        cell.setViewModel(viewModel)
        return cell
    }
    
    private func applySnapShot() {
        var snapShot: SnapShot = SnapShot()
        if let favorites = viewModel.state.tableViewModel {
            snapShot.appendSections([.favorite])
            snapShot.appendItems(favorites, toSection: .favorite)
        }
        dataSource.apply(snapShot)
    }
}
