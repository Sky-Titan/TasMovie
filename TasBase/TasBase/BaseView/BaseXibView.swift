//
//  BaseXibView.swift
//  TasBase
//
//  Created by 박준현 on 2021/11/29.
//

import UIKit

open class BaseXibView: UIView {
    
    @IBOutlet open weak var contentView: UIView!
    
    open func nibName() -> String? {
        return nil
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    
    private func loadNib() {
        if let name = nibName() {
            Bundle(for: type(of: self)).loadNibNamed(name, owner: self, options: nil)
            self.addSubview(contentView)
            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            didFinishLoadingNib()
        }
    }
    
    open override func awakeFromNib() {
    }
    
    open func didFinishLoadingNib() {
        
    }
}
