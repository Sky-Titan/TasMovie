//
//  SecondViewController.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/20.
//

import UIKit
import TasBase

class SecondViewController: TSViewController {
    
    @IBOutlet weak var tabBarView: TabBarView!
    @IBOutlet weak var tabBarHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarView.tabBarController = self.tabBarController
        tabBarHeight.constant = TabBarView.Const.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
