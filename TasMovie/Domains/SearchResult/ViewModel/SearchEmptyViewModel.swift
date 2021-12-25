//
//  SearchEmptyViewModel.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/25.
//

import UIKit
import TasBase

class SearchEmptyViewModel: FrontViewModelProtocol {
    var frontViewProperty: FrontViewProperty
    
    var text: String {
        return "검색 결과가 없습니다."
    }
    
    var iconImage: String {
        return "questionmark.square.dashed"
    }
    
    init() {
        frontViewProperty = FrontViewProperty(cellSize: .zero, className: SearchEmptyView.className())
        frontViewProperty.cellSize = SearchEmptyView.size(self)
    }
}
