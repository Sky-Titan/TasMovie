//
//  GenreItemView.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/25.
//

import UIKit
import TasBase

class GenreItemView: BaseXibView, FrontViewProtocol {
    
    @IBOutlet weak var button: UIButton!
    
    func setViewModel(_ viewModel: FrontViewModelProtocol) {
        guard let viewModel = viewModel as? GenreItemViewModel else { return }
        button.setTitle(viewModel.name, for: .normal)
    }
    
    static func size(_ data: FrontViewModelProtocol) -> CGSize {
        guard let viewModel = data as? GenreItemViewModel else { return .zero }
        let width: CGFloat = viewModel.name.width(withConstrainedHeight: 40, font: .systemFont(ofSize: 14)) + 20
        return CGSize(width: width, height: 40)
    }
    
    
    override func nibName() -> String? {
        return "GenreItemView"
    }
}
