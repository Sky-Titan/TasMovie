//
//  SpinWheelView.swift
//  TasExample
//
//  Created by 박준현 on 2021/12/11.
//

import UIKit
import TasUtility

public class SpinWheelView: UIView {
    
    public var spinWheelLayer: SpinWheelLayer {
        return layer as! SpinWheelLayer
    }
    
    public override class var layerClass: AnyClass {
        return SpinWheelLayer.self
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        doInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        doInit()
    }
    
    private func doInit() {
        let recognizer = SpinGestureRecognizer(target: self, action: #selector(handleRotateGesture(recognizer:)), center: CGPoint(x: frame.width / 2, y: frame.height / 2))
        //UIRotationGestureRecognizer(target: self, action: #selector(handleRotateGesture(recognizer:)))
        addGestureRecognizer(recognizer)
        layer.setNeedsDisplay()
    }
    
    @objc
    private func handleRotateGesture(recognizer: SpinGestureRecognizer) {
        print(recognizer.state.rawValue.description)
        if let rotationView = recognizer.view, recognizer.state == .changed {
            rotationView.transform = rotationView.transform.rotated(by: recognizer.rotation)
            print(recognizer.rotation.toDegress())
            recognizer.rotation = 0.0
        }
    }
}

public class SpinGestureRecognizer: UIGestureRecognizer {
    
    var rotation: CGFloat = 0
    var velocity: CGFloat = 0
    var center: CGPoint = .zero
    
    var formerPoint: CGPoint = .zero
    var currentPoint: CGPoint = .zero
    
    public convenience init(target: Any?, action: Selector?, center: CGPoint) {
        self.init(target: target, action: action)
        self.center = center
    }
    
    private override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        formerPoint = getTouchPosition(from: touches, in: view)
        state = .began
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        defer {
            formerPoint = currentPoint
        }
        
        currentPoint = getTouchPosition(from: touches, in: view)
        print("formerPoint \(formerPoint)")
        print("currentPoint \(currentPoint)")
        rotation = getAngle(first: formerPoint, second: currentPoint)
        state = .changed
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        state = .ended
        
    }
    
    private func getTouchPosition(from touches: Set<UITouch>, in view: UIView?) -> CGPoint {
        guard let touch = touches.first else { return .zero }
        let coordinate = touch.location(in: view)
        return CGPoint(x: coordinate.x - center.x, y: center.y - coordinate.y)
    }
    
    // angle is Radians
    private func getAngle(first point1: CGPoint, second point2: CGPoint) -> CGFloat {
        return atan2(point1.y * point2.x - point1.x * point2.y, point1.x * point2.x + point1.y * point2.y)
    }
}

public class SpinWheelLayer: CALayer {
    
    var center: CGPoint {
        return CGPoint(x: frame.width / 2, y: frame.height / 2)
    }
    var radius: CGFloat {
        return min(frame.width, frame.height) / 2
    }
    
    public override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        
        ctx.addArc(center: center, radius: radius, startAngle: Degrees(0).toRadians(), endAngle: Degrees(360).toRadians(), clockwise: true)
        ctx.setFillColor(UIColor.green.cgColor)
        ctx.fillPath()
        
        ctx.move(to: CGPoint(x: 0, y: frame.height / 2))
        ctx.setLineWidth(5)
        ctx.addLine(to: CGPoint(x: frame.width, y: frame.height / 2))
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.strokePath()
        ctx.fillPath()
        
        
    }
}
