//
//  CircleProgressView.swift
//  TasExample
//
//  Created by 박준현 on 2021/12/05.
//

import UIKit
import TasUtility


public class CircleProgressView: UIView {
    
    @IBInspectable
    public var progressColor: UIColor? {
        didSet {
            circleLayer.progressColor = progressColor
            circleLayer.setNeedsDisplay()
        }
    }
    @IBInspectable
    public var progressBackgroundColor: UIColor? {
        didSet {
            circleLayer.progressBackgroundColor = progressBackgroundColor
            circleLayer.setNeedsDisplay()
        }
    }
    @IBInspectable
    public var progress: CGFloat = 0 {
        didSet {
            circleLayer.progress = progress
            circleLayer.setNeedsDisplay()
        }
    }
    @IBInspectable
    public var progressWidth: CGFloat = 0 {
        didSet {
            circleLayer.progressWidth = progressWidth
            circleLayer.setNeedsDisplay()
        }
    }
    @IBInspectable
    public var clockwise: Bool {
        set {
            circleLayer.clockwise = !newValue
            circleLayer.setNeedsDisplay()
        }
        
        get {
            return !circleLayer.clockwise
        }
    }
    
    private var circleLayer: CircleLayer {
        return layer as! CircleLayer
    }
    
    public override class var layerClass: AnyClass {
        return CircleLayer.self
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func startProgressAnimate() {
        circleLayer.animate()
    }
}

class CircleLayer: CALayer {
    
    public var progressWidth: CGFloat = 0
    public var progressColor: UIColor?
    public var progressBackgroundColor: UIColor?
    public var progress: CGFloat = 0
    public var clockwise: Bool = false
    public var progressLayer: CAShapeLayer?
    var center: CGPoint {
        return CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
    }
    var radius: CGFloat {
        return min(frame.size.width, frame.size.height) / 2
    }
    private let startAngle: Radians = Degrees(0).toRadians()
    private let endAngle: Radians = Degrees(360).toRadians()
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        
        addCenterCircle(ctx)
        addProgressBackground(ctx)
        
        if progressLayer == nil {
            let progressLayer = CAShapeLayer()
            self.progressLayer = progressLayer
        
            setProgressLayerStyle()
            addSublayer(progressLayer)
        } else {
            setProgressLayerStyle()
        }
    }
    
    private func addCenterCircle(_ ctx: CGContext) {
        ctx.addArc(center: center, radius: radius - progressWidth / 2, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fillPath()
    }
    
    private func addProgressBackground(_ ctx: CGContext) {
        ctx.addArc(center: center, radius: radius - progressWidth / 2, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        ctx.setLineWidth(progressWidth)
        ctx.setStrokeColor(progressBackgroundColor?.cgColor ?? UIColor.white.cgColor)
        ctx.strokePath()
        ctx.fillPath()
    }
    
    private func setProgressLayerStyle() {
        progressLayer?.path = UIBezierPath(arcCenter: center, radius: radius - progressWidth / 2, startAngle: startAngle - Degrees(90).toRadians(), endAngle: endAngle - Degrees(90).toRadians(), clockwise: clockwise).cgPath
        progressLayer?.lineCap = .round
        progressLayer?.lineWidth = progressWidth
        progressLayer?.fillColor = UIColor.clear.cgColor
        progressLayer?.strokeColor = progressColor?.cgColor
        progressLayer?.strokeStart = 0
        progressLayer?.strokeEnd = progress
        progressLayer?.setNeedsDisplay()
    }
    
    func animate() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = progress
        animation.repeatCount = 1
        animation.duration = 0.7
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        progressLayer?.add(animation, forKey: "StrokeAnimation")
    }
}
