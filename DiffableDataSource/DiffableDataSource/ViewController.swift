//
//  ViewController.swift
//  DiffableDataSource
//
//  Created by 강희선 on 2021/11/21.
//

import UIKit

class ViewController: UICollectionViewController {
    private var sections = Section.sections
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Person>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Person>
    
    private lazy var dataSource = makeDataSource()
    private var searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureSearchController()
        configureLayout()
        applySnapshot(animatingDifferences: false)
    }
    func applySnapshot(animatingDifferences: Bool = true){
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        sections.forEach { section in
            snapshot.appendItems(section.people, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    func makeDataSource() -> DataSource{
        let dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, person) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCollectionViewCell", for: indexPath) as? PersonCollectionViewCell
            cell?.person = person
            return cell
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderReusableView.identifier, for: indexPath) as? SectionHeaderReusableView
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            view?.titleLabel.text = section.title
            return view
        }
        return dataSource
    }
}

extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        sections = filteredSections(for: searchController.searchBar.text)
        applySnapshot()
    }
    
    func filteredSections(for queryOrNil: String?) -> [Section] {
        let sections = Section.sections
        guard let query = queryOrNil, !query.isEmpty else { return sections }
        return sections.filter { section in
            var matches = section.title.lowercased().contains(query.lowercased())
            for person in section.people{
                if person.name.lowercased().contains(query.lowercased()){
                    matches = true
                    break
                }
            }
            return matches
        }
    }
    
    func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}


extension ViewController{
    private func configureLayout(){
        collectionView.register(SectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderReusableView.identifier)
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let size = NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0), heightDimension: NSCollectionLayoutDimension.estimated(60))
            let itemCnt = 1
            let item = NSCollectionLayoutItem(layoutSize: size)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: itemCnt)
            let section = NSCollectionLayoutSection(group: group)
//            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.interGroupSpacing = 10
            
            // header view
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(20))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            return section
        })
    }
}
//extension ViewController: SFSafariViewControllerDelegate {
//  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
//    controller.dismiss(animated: true, completion: nil)
//  }
//}
