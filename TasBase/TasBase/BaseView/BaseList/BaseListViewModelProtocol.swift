//
//  BaseListViewModelProtocol.swift
//  TasBase
//
//  Created by 박준현 on 2021/12/28.
//

import UIKit

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
    func viewModelRefreshedCells(_ viewModel: BaseListViewModel, at indexPaths: [IndexPath])
    func viewModelRefreshedSections(_ viewModel: BaseListViewModel, sections: IndexSet)
}

public class FrontSection {
    public var headerViewModel: FrontViewModelProtocol?
    public var footerViewModel: FrontViewModelProtocol?
    public var cellViewModels: [FrontViewModelProtocol] = []
    public var sectionHeight: CGFloat {
        return (headerViewModel?.frontViewProperty.cellSize.height ?? 0) + (footerViewModel?.frontViewProperty.cellSize.height ?? 0) + cellViewModels.reduce(CGFloat(0)) { result, item in
            return result + item.frontViewProperty.cellSize.height
        }
    }
    public init() {
        
    }
}

extension Array where Element == FrontSection {
    public var listHeight: CGFloat {
        return self.reduce(CGFloat(0), {
            return $0 + $1.sectionHeight
        })
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

