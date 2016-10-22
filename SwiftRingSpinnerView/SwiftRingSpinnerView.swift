//
//  SwiftRingSpinnerView.swift
//  SwiftRingSpinnerView
//
//  Created by Jonathan Siao on 22/10/2016.
//
//

import Foundation
import UIKit


var SwiftRingSpinnerAnimationKey = "swiftringspinnerview.rotation"

class SwiftRingSpinnerView:UIView {
    private var currentProgressLayer:CAShapeLayer?=nil
    private var hidesWhenStopped = false
    private var timingFunction = CAMediaTimingFunction()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        timingFunction = CAMediaTimingFunction.init(name:kCAMediaTimingFunctionEaseInEaseOut)
        layer.addSublayer(self.progressLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        progressLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        updatePath()
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        progressLayer.strokeColor = self.tintColor!.cgColor
    }
    
    func startAnimating() {
        if !isAnimating() {
            let animation = CABasicAnimation()
            animation.keyPath = "transform.rotation"
            animation.duration = 1.0
            animation.fromValue = (0.0)
            animation.toValue = (2 * 3.142)
            animation.repeatCount = .infinity
            animation.timingFunction = self.timingFunction
            progressLayer.add(animation, forKey: SwiftRingSpinnerAnimationKey)
        }
        if self.hidesWhenStopped {
            isHidden = false
        }
    }
    
    func stopAnimating() {
        if self.isAnimating() {
            self.progressLayer.removeAnimation(forKey: SwiftRingSpinnerAnimationKey)
        }
        if self.hidesWhenStopped {
            isHidden = true
        }
    }
    // MARK: - Private
    
    func updatePath() {
        let center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        let radius: CGFloat = min(self.bounds.width / 2, self.bounds.height / 2) - self.progressLayer.lineWidth / 2
        let startAngle: CGFloat = CGFloat(-M_PI_4)
        let endAngle: CGFloat = CGFloat(3 * M_PI_2)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        progressLayer.path = path.cgPath
    }
    // MARK: - Properties
    
    var progressLayer:CAShapeLayer {
        if (currentProgressLayer == nil) {
            currentProgressLayer = CAShapeLayer()
            if let currentProgressLayer = currentProgressLayer{
                currentProgressLayer.strokeColor = self.tintColor!.cgColor
                currentProgressLayer.fillColor = nil
                currentProgressLayer.lineWidth = 1.5
            }
        }
        return currentProgressLayer!
    }
    
    func isAnimating() -> Bool {
        return progressLayer.animation(forKey: SwiftRingSpinnerAnimationKey) != nil
    }
    
    func lineWidth() -> CGFloat {
        return progressLayer.lineWidth
    }
    
    func setLineWidth(lineWidth: CGFloat) {
        progressLayer.lineWidth = lineWidth
        updatePath()
    }
    
    func setHidesWhenStopped(hidesWhenStopped: Bool) {
        self.hidesWhenStopped = hidesWhenStopped
        isHidden = !isAnimating() && hidesWhenStopped
    }
}
