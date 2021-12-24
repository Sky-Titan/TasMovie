//
//  SearchResultItemView.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/24.
//

import UIKit
import TasBase
import SDWebImage

class SearchResultItemView: BaseXibView, FrontViewProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func nibName() -> String? {
        return "SearchResultItemView"
    }
    
    func setViewModel(_ viewModel: FrontViewModelProtocol) {
        guard let viewModel = viewModel as? SearchResultItemViewModel else { return }
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.overview
        if let imageUrl = viewModel.imageUrl {
            imageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
    }
    
    static func size(_ data: FrontViewModelProtocol) -> CGSize {
        guard let viewModel = data as? SearchResultItemViewModel else { return .zero }
        let overviewHeight = min((viewModel.overview ?? "").height(withConstrainedWidth: UIScreen.mainWidth - 48, font: .systemFont(ofSize: 17)), 41)
        return CGSize(width: UIScreen.mainWidth, height: 20 + 24 + 20 + (UIScreen.mainWidth - 48) * 1.3 + 20 + overviewHeight + 20)
    }
}
