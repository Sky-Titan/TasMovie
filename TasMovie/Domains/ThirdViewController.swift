//
//  ThirdViewController.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/20.
//

import UIKit
import TasBase

class ThirdViewController: TSViewController {
    
    @IBOutlet weak var tabBarView: TabBarView!
    @IBOutlet weak var tabBarHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarView.tabBarController = self.tabBarController
        tabBarHeight.constant = TabBarView.Const.height
    }
}
