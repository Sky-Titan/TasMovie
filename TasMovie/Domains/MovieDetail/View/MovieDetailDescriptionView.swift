//
//  MovieDetailDescriptionView.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/24.
//

import UIKit
import TasBase

class MovieDetailDescriptionView: BaseXibView, FrontViewProtocol {
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    func setViewModel(_ viewModel: FrontViewModelProtocol) {
        guard let viewModel = viewModel as? MovieDetailDescriptionViewModel else { return }
        releasedDateLabel.text = viewModel.release_date
        statusLabel.text = viewModel.status.rawValue
        popularityLabel.text = viewModel.popularity.description
        runtimeLabel.text = "\(viewModel.runtime ?? 0)분"
        overviewLabel.text = viewModel.overview
    }
    
    static func size(_ data: FrontViewModelProtocol) -> CGSize {
        guard let viewModel = data as? MovieDetailDescriptionViewModel else { return .zero }
        var overviewHeight: CGFloat = 0
        
        if let overview = viewModel.overview {
            overviewHeight += overview.height(withConstrainedWidth: UIScreen.mainWidth - 48, font: .systemFont(ofSize: 14))
        }
        
        return CGSize(width: UIScreen.mainWidth, height: overviewHeight + 132 + 17 + 20)
    }
    
    
    override func nibName() -> String? {
        return "MovieDetailDescriptionView"
    }
    
    
}
