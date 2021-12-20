//
//  AnchorPointPracticeView.swift
//  Practice
//
//  Created by 박준현 on 2021/12/08.
//

import UIKit

public class AnchorPointPracticeView: UIView {
    
    public var rectLayer: CAShapeLayer?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = frame.width / 2
    }
  
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addRectLayer()
        addCenterDot()
    }
    
    private func addRectLayer() {
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: frame.width / 2, height: 10))
        path.close()
        let rectLayer = CAShapeLayer()
        rectLayer.frame = path.bounds // 중요: frame을 지정해주어야 anchorPoint가 동작한다.
        rectLayer.fillColor = UIColor.red.cgColor
        rectLayer.anchorPoint = CGPoint(x: 0, y: 0) // layer 좌측상단 지점으로 초기화
        rectLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2) // anchorPoint가 위치할 곳 (부모뷰 기준 좌표 -> 현재는 부모뷰의 정중앙에 위치하겠다는 뜻)
        rectLayer.path = path.cgPath
        
        rectLayer.setNeedsDisplay()
        self.layer.addSublayer(rectLayer)
        self.rectLayer = rectLayer
    }
    
    //중앙 표시 점 layer 추가
    private func addCenterDot() {
        let dotLayer = CAShapeLayer()
        dotLayer.path = UIBezierPath(arcCenter: CGPoint(x: frame.width / 2, y: frame.height / 2), radius: 5, startAngle: 0, endAngle: 2 * .pi, clockwise: true).cgPath
        dotLayer.fillColor = UIColor.blue.cgColor
        dotLayer.setNeedsDisplay()
        self.layer.addSublayer(dotLayer)
    }
    
    //수동으로 anchorPoint 지정
    public func setRectLayerAnchorPoint(point: CGPoint) {
        rectLayer?.anchorPoint = point
    }
    
    public func rotate() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = 2 * CGFloat.pi
        rotateAnimation.duration = 0.5
        rotateAnimation.isRemovedOnCompletion = true
        
        self.rectLayer?.add(rotateAnimation, forKey: "rotate")
    }
}
