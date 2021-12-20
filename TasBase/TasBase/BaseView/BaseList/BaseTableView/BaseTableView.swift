//
//  BaseTableView.swift
//  TasBase
//
//  Created by 박준현 on 2021/11/29.
//

import UIKit

open class BaseTableView: UITableView, BaseListViewProtocol {
    
    public var viewModel: BaseListViewModel?
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        doInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        doInit()
    }
    
    private func doInit() {
        register(BaseTableCellView.self, forCellReuseIdentifier: BaseTableCellView.identifierStringForReuse)
        register(BaseTableHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: BaseTableHeaderFooterView.identifierStringForReuse)
        self.dataSource = self
        self.delegate = self
    }
}
extension BaseTableView: BaseListViewModelDelegate {
    public func viewModelRefreshedCells(at indexPaths: [IndexPath]) {
        reloadRows(at: indexPaths, with: .top)
    }
    
    public func viewModelRefreshedSections(sections: IndexSet) {
        reloadSections(sections, with: .top)
    }
    
    public func viewModelRefreshed(_ viewModel: BaseListViewModel) {
        self.viewModel = viewModel
        reloadData()
    }
}

extension BaseTableView: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let sourceViewModel = viewModel?.viewModel(at: sourceIndexPath), let destViewModel = viewModel?.viewModel(at: destinationIndexPath) else { return }
        
        viewModel?.frontSections[sourceIndexPath.section].cellViewModels[sourceIndexPath.row] = destViewModel
        viewModel?.frontSections[destinationIndexPath.section].cellViewModels[destinationIndexPath.row] = sourceViewModel
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.viewModel(at: indexPath)?.frontViewProperty.cellSize.height ?? 0
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.frontSections.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.frontSections[section].cellViewModels.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let frontViewModel = viewModel?.viewModel(at: indexPath) else { fatalError() }
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseTableCellView.identifierStringForReuse, for: indexPath) as! BaseTableCellView
        cell.setViewModel(frontViewModel, to: cell.contentView)
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let touchable = viewModel?.frontSections[indexPath.section].cellViewModels[indexPath.row] as? Touchable else { return }
        touchable.onTouch()
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = viewModel?.frontSections[safe: section]?.footerViewModel else { return nil }
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: BaseTableHeaderFooterView.identifierStringForReuse) as! BaseTableHeaderFooterView
        footerView.setViewModel(footer, to: footerView.contentView)
        return footerView
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = viewModel?.frontSections[safe: section]?.headerViewModel else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: BaseTableHeaderFooterView.identifierStringForReuse) as! BaseTableHeaderFooterView
        headerView.setViewModel(header, to: headerView.contentView)
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let footer = viewModel?.frontSections[safe: section]?.footerViewModel else { return .zero }
        return footer.frontViewProperty.cellSize.height
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let header = viewModel?.frontSections[safe: section]?.headerViewModel else { return .zero }
        return header.frontViewProperty.cellSize.height
    }
}

public protocol Touchable: AnyObject {
    var touch: (() -> Void)? { get set }
    func onTouch()
}

public protocol BaseListViewModel {
    var frontSections: [FrontSection] { get set }
    var delegate: BaseListViewModelDelegate? { get set }
    func resetModel()
}
extension BaseListViewModel {
    public func viewModel(at indexPath: IndexPath) -> FrontViewModelProtocol? {
        return frontSections[indexPath.section].cellViewModels[indexPath.row]
    }
}

public protocol BaseListViewModelDelegate: AnyObject {
    func viewModelRefreshed(_ viewModel: BaseListViewModel)
    func viewModelRefreshedCells(at indexPaths: [IndexPath])
    func viewModelRefreshedSections(sections: IndexSet)
}

public class FrontSection {
    public var headerViewModel: FrontViewModelProtocol?
    public var footerViewModel: FrontViewModelProtocol?
    public var cellViewModels: [FrontViewModelProtocol] = []
    
    public init() {
        
    }
}

public protocol FrontViewModelProtocol: AnyObject {
    var frontViewProperty: FrontViewProperty { get set }
}

public protocol FrontViewProtocol: AnyObject {
    
    func setViewModel(_ viewModel: FrontViewModelProtocol)
    static func size(_ data: FrontViewModelProtocol) -> CGSize
}

public class FrontViewProperty {
    public var cellSize: CGSize
    public var className: String
    
    public init(cellSize: CGSize, className: String) {
        self.cellSize = cellSize
        self.className = className
    }
}
