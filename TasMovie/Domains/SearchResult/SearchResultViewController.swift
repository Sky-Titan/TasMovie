//
//  SearchResultViewController.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/20.
//

import UIKit
import TasBase
import TasNetwork

class SearchResultViewController: TSViewController, SearchDataProvider, RequestFinishedDelegate {

    @IBOutlet weak var tabBarView: TabBarView!
    @IBOutlet weak var tabBarHeight: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: BaseTableView!
    let listViewModel = SearchResultListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarView.tabBarController = self.tabBarController
        tabBarHeight.constant = TabBarView.Const.height
        
        tableView.viewModel = listViewModel
        tableView.scrollDelegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        searchBar.delegate = self
        listViewModel.requestFinishedDelegate = self
        listViewModel.delegate = tableView
    }
    
    func requestSucceed() {
        tableView.refreshControl?.endRefreshing()
        //TODO: remove indicator
    }
    
    func requestFailed() {
        tableView.refreshControl?.endRefreshing()
        //TODO: remove indicator
    }
    
    @objc
    func refresh() {
        listViewModel.search(query: searchBar.text ?? "")
    }
    
    func search(query: String) {
        //TODO: indicator
        listViewModel.search(query: query)
    }
}

extension SearchResultViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        listViewModel.search(query: searchBar.text ?? "")
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
}

extension SearchResultViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y + tableView.frame.size.height >= tableView.contentSize.height {
            listViewModel.getNextPage()
        }
    }
}
