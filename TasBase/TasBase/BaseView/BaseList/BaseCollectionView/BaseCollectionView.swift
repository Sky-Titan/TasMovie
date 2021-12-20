//
//  BaseCollectionView.swift
//  TasBase
//
//  Created by 박준현 on 2021/12/11.
//

import UIKit

open class BaseCollectionView: UICollectionView, BaseListViewProtocol {
    
    public var viewModel: BaseListViewModel?
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        doInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        doInit()
    }
    
    private func doInit() {
        register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: BaseCollectionViewCell.identifierStringForReuse)
        register(BaseCollectionHeaderFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BaseCollectionHeaderFooterView.identifierStringForReuse)
        register(BaseCollectionHeaderFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: BaseCollectionHeaderFooterView.identifierStringForReuse)
        self.dataSource = self
        self.delegate = self
    }
}

extension BaseCollectionView: BaseListViewModelDelegate {
    public func viewModelRefreshed(_ viewModel: BaseListViewModel) {
        reloadData()
    }
    
    public func viewModelRefreshedCells(at indexPaths: [IndexPath]) {
        reloadItems(at: indexPaths)
    }
    
    public func viewModelRefreshedSections(sections: IndexSet) {
        reloadSections(sections)
    }
}

extension BaseCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.frontSections.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.frontSections[safe: section]?.cellViewModels.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let frontViewModel = viewModel?.viewModel(at: indexPath) else { fatalError() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseCollectionViewCell.identifierStringForReuse, for: indexPath) as! BaseCollectionViewCell
        cell.setViewModel(frontViewModel, to: cell.contentView)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let header = viewModel?.frontSections[safe: section]?.headerViewModel else { return .zero }
        return header.frontViewProperty.cellSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let footer = viewModel?.frontSections[safe: section]?.footerViewModel else { return .zero }
        return footer.frontViewProperty.cellSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BaseCollectionHeaderFooterView.identifierStringForReuse, for: indexPath) as! BaseCollectionHeaderFooterView
        
        if kind == UICollectionView.elementKindSectionHeader, let header = viewModel?.frontSections[safe: indexPath.section]?.headerViewModel {
            cell.setViewModel(header, to: cell)
            return cell
        } else if kind == UICollectionView.elementKindSectionFooter, let footer = viewModel?.frontSections[safe: indexPath.section]?.footerViewModel {
            cell.setViewModel(footer, to: cell)
            return cell
        }
        return BaseCollectionHeaderFooterView()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel?.viewModel(at: indexPath)?.frontViewProperty.cellSize ?? .zero
    }
}
