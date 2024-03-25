//
//  CircularTransition.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 22.03.2024.
//

import UIKit

enum CircularTransitionMode {
    case present, dismiss
}

final class CircularTransition: NSObject {
    private var circle = UIView()
    
    public var circleColor: UIColor = .white
    public var duration = 0.6
    public var transitionMode: CircularTransitionMode = .present
    public var startingPoint = CGPoint.zero {
        didSet  {
            circle.center = startingPoint
        }
    }
    
    private func getFrameForCircle(size: CGSize, startPoint: CGPoint) -> CGRect {
        let xLeght = fmax(startPoint.x, size.width - startPoint.x)
        let yLeght = fmax(startPoint.y, size.height - startPoint.y)
        
        let offsetVector = sqrt(xLeght * xLeght + yLeght * yLeght) * 2
        let size = CGSize(width: offsetVector, height: offsetVector)
        
        return CGRect(origin: .zero, size: size)
    }
}

extension CircularTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        if transitionMode == .present {
            if let presentedView = transitionContext.viewController(forKey: .to) {
                let viewCenter = presentedView.view.center
                let viewSize = presentedView.view.frame.size
                circle = UIView()
                circle.frame = getFrameForCircle(size: viewSize, startPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.width / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                
                containerView.addSubview(circle)
                
                presentedView.view.center = startingPoint
                presentedView.view.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.view.alpha = 0
                containerView.addSubview(presentedView.view)
                
                UIView.animate(withDuration: duration) {
                    self.circle.transform = CGAffineTransform.identity
                    presentedView.view.transform = CGAffineTransform.identity
                    presentedView.view.alpha = 1
                    presentedView.view.center = viewCenter
//                    presentedView.center = CGPoint(x: 0, y: 0)
                } completion: { succes in
                    transitionContext.completeTransition(succes)
                }
            }
        } else {
            if let retrunView = transitionContext.view(forKey: .from) {
                let viewSize = retrunView.frame.size
                circle.frame = getFrameForCircle(size: viewSize, startPoint: startingPoint)
                circle.layer.cornerRadius  = circle.frame.width / 2
                circle.center = startingPoint
                
                UIView.animate(withDuration: duration) {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    retrunView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    retrunView.center = self.startingPoint
                    retrunView.alpha = 0
                } completion: { succes in
                    retrunView.removeFromSuperview()
                    self.circle.removeFromSuperview()
                    
                    transitionContext.completeTransition(succes)
                }
            }
        }
    }
}
