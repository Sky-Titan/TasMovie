//
//  MovieDetailViewController.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/24.
//

import UIKit
import TasBase
import TasNetwork

class MovieDetailViewController: TSViewController, RequestFinishedDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: BaseTableView!
    
    var id: Int?
    let listViewModel = MovieDetailListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.viewModel = listViewModel
        listViewModel.delegate = tableView
        listViewModel.id = id
        listViewModel.requestFinishedDelegate = self
        refresh()
    }
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func refresh() {
        showIndicator()
        listViewModel.resetModel()
    }
    
    func requestSucceed() {
        removeIndicator()
        titleLabel.text = listViewModel.title
    }
    
    func requestFailed() {
        removeIndicator()
    }
}
