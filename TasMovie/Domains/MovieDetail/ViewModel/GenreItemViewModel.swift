//
//  GenreItemViewModel.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/25.
//

import UIKit
import TasBase

class GenreItemViewModel: FrontViewModelProtocol {
    var frontViewProperty: FrontViewProperty
    
    var name: String {
        return model.name
    }
    
    private let model: GenreModel
    init(model: GenreModel) {
        self.model = model
        frontViewProperty = FrontViewProperty(cellSize: .zero, className: GenreItemView.className())
        frontViewProperty.cellSize = GenreItemView.size(self)
    }
}
