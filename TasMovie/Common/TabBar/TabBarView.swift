//
//  TabBarView.swift
//  TasMovie
//
//  Created by 박준현 on 2021/12/20.
//

import UIKit
import TasBase
import TasUtility

class TabBarView: BaseXibView {
    
    @IBOutlet weak var firstItem: UIButton!
    @IBOutlet weak var secondItem: UIButton!
    @IBOutlet weak var thirdItem: UIButton!
    
    var tabBarController: UITabBarController? {
        didSet {
            guard let tabBarController = tabBarController else {
                return
            }
            
            firstItem.setTitleColor(Const.unselectedColor, for: .normal)
            secondItem.setTitleColor(Const.unselectedColor, for: .normal)
            thirdItem.setTitleColor(Const.unselectedColor, for: .normal)

            switch tabBarController.selectedIndex {
            case 0:
                firstItem.setTitleColor(Const.selectedColor, for: .normal)
            case 1:
                secondItem.setTitleColor(Const.selectedColor, for: .normal)
            case 2:
                thirdItem.setTitleColor(Const.selectedColor, for: .normal)
            default:
                break
            }
        }
    }
    
    override func nibName() -> String? {
        return "TabBarView"
    }
    
    override func didFinishLoadingNib() {
        super.didFinishLoadingNib()
        
        
    }
    
    @IBAction func firstClick(_ sender: Any) {
        tabBarController?.selectedIndex = 0
    }
    
    @IBAction func secondClick(_ sender: Any) {
        tabBarController?.selectedIndex = 1
    }
    
    @IBAction func thirdClick(_ sender: Any) {
        tabBarController?.selectedIndex = 2
    }
    
    enum Const {
        static let selectedColor = UIColor.red
        static let unselectedColor = UIColor.link
    }
}
