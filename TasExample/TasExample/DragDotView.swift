//
//  DragDotView.swift
//  Practice
//
//  Created by 박준현 on 2021/12/05.
//

import UIKit

public class DraggableView: UIView {
 
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        moveCenter(to: touches)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        moveCenter(to: touches)
    }
    
    private func moveCenter(to touches: Set<UITouch>) {
        guard let position = getTouchPosition(from: touches, in: superview) else { return }
        center = position
    }
    
    private func getTouchPosition(from touches: Set<UITouch>, in view: UIView?) -> CGPoint? {
        guard let touch = touches.first else { return nil }
        return touch.location(in: view)
    }
}

public class DragDotView: DraggableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    /// initialize View as a rounded red circle
    private func setupView() {
        backgroundColor = .red
        let min = min(frame.size.width, frame.size.height)
        layer.cornerRadius = min / 2
    }
}
