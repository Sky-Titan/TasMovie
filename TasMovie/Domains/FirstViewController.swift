//
//  FirstViewController.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/20.
//

import UIKit
import TasBase

class FirstViewController: TSViewController {

    @IBOutlet weak var tabBarView: TabBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarView.tabBarController = self.tabBarController
        // Do any additional setup after loading the view.
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "First", image: nil, tag: 0)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

