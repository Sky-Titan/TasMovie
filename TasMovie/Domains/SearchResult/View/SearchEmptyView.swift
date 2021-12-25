//
//  SearchEmptyView.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/25.
//

import UIKit
import TasBase

class SearchEmptyView: BaseXibView, FrontViewProtocol {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setViewModel(_ viewModel: FrontViewModelProtocol) {
        guard let viewModel = viewModel as? SearchEmptyViewModel else { return }
        imageView.image = UIImage(systemName: viewModel.iconImage)
        descriptionLabel.text = viewModel.text
    }
    
    static func size(_ data: FrontViewModelProtocol) -> CGSize {
        return CGSize(width: UIScreen.mainWidth, height: UIScreen.mainHeight - 201)
    }
    
    override func nibName() -> String? {
        return "SearchEmptyView"
    }
}
