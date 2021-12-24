//
//  MovieDetailDescriptionView.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/24.
//

import UIKit
import TasBase

class MovieDetailDescriptionView: BaseXibView, FrontViewProtocol {
    
    
    func setViewModel(_ viewModel: FrontViewModelProtocol) {
        
    }
    
    static func size(_ data: FrontViewModelProtocol) -> CGSize {
        guard let viewModel = data as? MovieDetailDescriptionViewModel else { return .zero }
        return CGSize(width: UIScreen.mainWidth, height: 132 + 17 + (viewModel.overview ?? "").height(withConstrainedWidth: UIScreen.mainWidth - 48, font: .systemFont(ofSize: 14) + 20)
    }
    
    
    override func nibName() -> String? {
        return "MovieDetailDescriptionView"
    }
    
    
}
