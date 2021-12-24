//
//  MovieDetailPosterView.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/24.
//

import UIKit
import TasBase

class MovieDetailPosterView: BaseXibView, FrontViewProtocol {
    @IBOutlet weak var imageView: UIImageView!
    
    func setViewModel(_ viewModel: FrontViewModelProtocol) {
        guard let viewModel = viewModel as? MovieDetailPosterViewModel else { return }
        if let imageUrl = viewModel.imageUrl {
            imageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
    }
    
    static func size(_ data: FrontViewModelProtocol) -> CGSize {
        return CGSize(width: UIScreen.mainWidth, height: (UIScreen.mainWidth - 48) * 1.3 + 40)
    }
    
    
    override func nibName() -> String? {
        return "MovieDetailPosterView"
    }
}
