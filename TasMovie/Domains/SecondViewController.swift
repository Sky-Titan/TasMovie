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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarView.tabBarController = self.tabBarController
    }
}
