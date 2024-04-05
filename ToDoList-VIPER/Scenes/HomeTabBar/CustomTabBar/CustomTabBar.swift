//
//  CustomTabBar.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 11.03.2024.
//

import UIKit

class CustomTabBar: UITabBar {

    private var shapeLayer: CALayer?
    
     func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
         shapeLayer.fillColor = UIColor.systemGray4.cgColor
        shapeLayer.lineWidth = 3.0
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOpacity = 0.3
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    override func draw(_ rect: CGRect) {
        self.addShape()
        self.unselectedItemTintColor = UIColor.white
        self.tintColor = UIColor(named: "PeachColor")
    }
    
    private func createPath() -> CGPath {
        let height: CGFloat = 15
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        path.move(to: CGPoint(x: 0, y: -20))// start position
        path.addLine(to: CGPoint(x: centerWidth - 50, y: 0))// left slope
        path.addQuadCurve(to: CGPoint(x: centerWidth - 30, y: 20),
                          controlPoint: CGPoint(x: centerWidth - 30, y: 5))
        path.addLine(to: CGPoint(x: centerWidth - 29, y: height - 10))
        path.addQuadCurve(to: CGPoint(x: centerWidth, y: height + 10),
                          controlPoint: CGPoint(x: centerWidth - 30, y: height + 10))
        path.addQuadCurve(to: CGPoint(x: centerWidth + 40, y: height - 10),
                          controlPoint: CGPoint(x: centerWidth + 40, y: height + 10))
        path.addLine(to: CGPoint(x: centerWidth + 41, y: 20))
        path.addQuadCurve(to: CGPoint(x: centerWidth + 50, y: 0),
                                       controlPoint: CGPoint(x: centerWidth + 41, y: 5))
        path.addLine(to: CGPoint(x: self.frame.width, y: -20))
                     
        //close the path
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height + 50))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height + 50))
        path.close()
        return path.cgPath
    }
}
