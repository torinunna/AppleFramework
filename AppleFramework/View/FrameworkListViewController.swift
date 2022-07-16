//
//  FrameworkListViewController.swift
//  AppleFramework
//
//  Created by 권유진 on 2022/07/13.
//

import UIKit
import Combine

class FrameworkListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias Item = AppleFramework
    enum Section {
        case main
    }

    var dataSource : UICollectionViewDiffableDataSource<Section, Item>!
    var subscriptions = Set<AnyCancellable>()
    
    var viewModel : FrameworkListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FrameworkListViewModel(items: AppleFramework.list)

        navigationController?.navigationBar.topItem?.title = "Apple Frameworks"
   
        configureCollectionView()
        bind()
    }
    
    private func bind() {
        viewModel.items
            .receive(on: RunLoop.main)
            .sink { [unowned self] list in applySectionItems(list)
        }.store(in: &subscriptions)
        
        viewModel.selectedItem
            .compactMap{ $0 }
            .receive(on: RunLoop.main)
            .sink { framework in
                let sb = UIStoryboard(name: "Detail", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                vc.viewModel = DetailViewModel(framework: framework)
                self.present(vc, animated: true)
            }.store(in: &subscriptions)
    }
    
    private func applySectionItems(_ items: [Item], to section: Section = .main) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        dataSource.apply(snapshot)
    }
    
    private func configureCollectionView() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrameworkCell", for: indexPath) as? FrameworkCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        
        collectionView.collectionViewLayout = layout()
        collectionView.delegate = self
        
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }

}

extension FrameworkListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelect(at: indexPath)
        }
    }

