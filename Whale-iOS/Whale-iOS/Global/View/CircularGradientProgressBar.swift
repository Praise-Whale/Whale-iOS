//
//  CircularGradientProgressBar.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/08/16.
//

import Foundation
import UIKit

class CircularGradientProgressBar: UIView {
  
  @IBInspectable public lazy var backgroundCircleColor: UIColor = UIColor.lightGray
  @IBInspectable public lazy var foregroundCircleColor: UIColor = UIColor.red
  @IBInspectable public lazy var startGradientColor: UIColor = UIColor.red
  @IBInspectable public lazy var endGradientColor: UIColor = UIColor.orange
  
  private lazy var fillColor: UIColor = UIColor.clear
  
  private var backgroundLayer: CAShapeLayer!
  private var progressLayer: CAShapeLayer!
  
  public var progress: CGFloat = 0 {
    didSet {
      didProgressUpdated()
    }
  }
  
  public var animationDidStarted: (()->())?
  public var animationDidCanceled: (()->())?
  public var animationDidStopped: (()->())?
  
  private var timer: AppTimer?
  private var isAnimating = false
  private let tickInterval = 0.1
  
  public var maxDuration: Int = 3
  
  
  override func draw(_ rect: CGRect) {
    
    guard layer.sublayers == nil else {
      return
    }
    
    let lineWidth = CGFloat(15.0)
    
    backgroundLayer = createCircularLayer(strokeColor: backgroundCircleColor.cgColor, fillColor: fillColor.cgColor, lineWidth: lineWidth)
    
    progressLayer = createCircularLayer(strokeColor: foregroundCircleColor.cgColor, fillColor: fillColor.cgColor, lineWidth: lineWidth)
    progressLayer.strokeEnd = progress
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 0, y: 0.4)
    
    gradientLayer.colors = [startGradientColor.cgColor, endGradientColor.cgColor]
    gradientLayer.frame = self.bounds
    gradientLayer.mask = progressLayer
    
    layer.addSublayer(backgroundLayer)
    layer.addSublayer(gradientLayer)
  }
  
  private func createCircularLayer(strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer {
    
    let startAngle = -CGFloat.pi / 2
    let endAngle = 2 * CGFloat.pi + startAngle
    
    let width = frame.size.width
    let height = frame.size.height
    
    let center = CGPoint(x: width / 2, y: height / 2)
    let radius = (min(width, height) - lineWidth) / 2
    
    let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    
    let shapeLayer = CAShapeLayer()
    
    shapeLayer.path = circularPath.cgPath
    
    shapeLayer.strokeColor = strokeColor
    shapeLayer.lineWidth = lineWidth
    shapeLayer.fillColor = fillColor
    shapeLayer.lineCap = .round
    
    return shapeLayer
  }
    
  private func didProgressUpdated() {
    progressLayer?.strokeEnd = progress
  }
}

// Animation
extension CircularGradientProgressBar {
  
  func startAnimation(duration: TimeInterval) {
    
    print("Start animation")
    isAnimating = true
    
    progressLayer.removeAllAnimations()
    
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    basicAnimation.duration = duration
    basicAnimation.toValue = progress
    
    basicAnimation.delegate = self
    
    timer = AppTimer(duration: maxDuration, tickInterval: tickInterval)
    timer?.timerCompleted = {}
    
    progressLayer.add(basicAnimation, forKey: "recording")
    timer?.start()
  }
  
  func stopAnimation() {
    timer?.stop()
    progressLayer.removeAllAnimations()
  }
  
}

extension CircularGradientProgressBar: CAAnimationDelegate {
  
  func animationDidStart(_ anim: CAAnimation) {
    animationDidStarted?()
  }
  
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    isAnimating = false
    flag ? animationDidStopped?() : animationDidCanceled?()
  }
}
