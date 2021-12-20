//
//  BaseListViewProtocol.swift
//  TasBase
//
//  Created by 박준현 on 2021/12/11.
//

import UIKit

protocol BaseListViewProtocol: AnyObject {
    var viewModel: BaseListViewModel? { get set }
}
