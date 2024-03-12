//
//  CustomHomeTabBar.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 11.03.2024.
//

import Foundation
import UIKit

final class CustomHomeTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func loadView() {
        super.loadView()
        addShape()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.selectedIndex = 1
        addSomeTabBarItems()
        setupMiddleButton()
    }
    
    private func addSomeTabBarItems() {
        let vc1 = ViewController()
        let vc2 = MockViewController()
        vc1.title = "Home"
        vc2.title = "Options"
        setViewControllers([vc1, vc2], animated: true)
        guard let items = tabBar.items else { return }
        items[0].image = UIImage(systemName: "house.fill")
        items[1].image = UIImage(systemName: "star.fill")
    }
    
    private func setupMiddleButton() {
        let middleButton = UIButton(frame: CGRect(x: (self.view.bounds.width / 2) - 25, y: -40, width: 60, height: 60))
//        var menuButtonFrame = middleButton.frame
//            menuButtonFrame.origin.y = self.view.bounds.height - menuButtonFrame.height
//            menuButtonFrame.origin.x = self.view.bounds.width / 2 - menuButtonFrame.size.width / 2
//        middleButton.frame = menuButtonFrame
        middleButton.layer.cornerRadius = 30
        middleButton.clipsToBounds = true
        middleButton.backgroundColor = .systemGreen
        middleButton.tintColor = .systemBackground
//        middleButton.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
        middleButton.setImage(UIImage(systemName: "plus"), for: .normal)
        middleButton.layer.shadowColor = UIColor.black.cgColor
        middleButton.layer.shadowOpacity = 0.1
        middleButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.tabBar.addSubview(middleButton)
        middleButton.addTarget(self, action: #selector(openAddNewToDo), for: .touchDown)
        self.view.layoutIfNeeded()
    }
    
//    private lazy var button: UIButton = {
//        let middleButton = UIButton(frame: CGRect(x: (self.view.bounds.width / 2) - 25, y: -40, width: 60, height: 60))
//        middleButton.layer.cornerRadius = 30
//        middleButton.clipsToBounds = true
//        middleButton.backgroundColor = .systemGreen
//        middleButton.tintColor = .systemBackground
//        middleButton.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
//        middleButton.isUserInteractionEnabled = true
////        middleButton.layer.shadowColor = UIColor.black.cgColor
////        middleButton.layer.shadowOpacity = 0.1
////        middleButton.layer.shadowOffset = CGSize(width: 4, height: 4)
////        self.tabBar.addSubview(middleButton)
//        middleButton.addTarget(self, action: #selector(openAddNewToDo), for: .touchUpInside)
//        return middleButton
//    }()
    
    @objc func openAddNewToDo() {
        let alertController = UIAlertController(title: "Hey", message: "Hey you press plus button", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Done", style: .cancel))
        self.present(alertController, animated: true)
        self.selectedIndex = 2
        print("Button is pushed")
    }
    
    //MARK: - Draw custom TabBar
    private var shapeLayer: CALayer?
    
    private func addShape() {
        self.tabBar.unselectedItemTintColor = UIColor.white
        self.tabBar.tintColor = .systemCyan
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.darkGray.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOpacity = 0.3
        if let oldShapeLayer = self.shapeLayer {
            self.tabBar.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.tabBar.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    private func createPath() -> CGPath {
        let height: CGFloat = 15
        let path = UIBezierPath()
        let centerWidth = self.tabBar.frame.width / 2
        path.move(to: CGPoint(x: 0, y: -20))// start position
        path.addLine(to: CGPoint(x: centerWidth - 50, y: 0))// left slope
        path.addQuadCurve(to: CGPoint(x: centerWidth - 30, y: 20),
                          controlPoint: CGPoint(x: centerWidth - 30, y: 5))//top left curve
        path.addLine(to: CGPoint(x: centerWidth - 29, y: height - 10))//left vertical line
        path.addQuadCurve(to: CGPoint(x: centerWidth, y: height + 10),
                          controlPoint: CGPoint(x: centerWidth - 30, y: height + 10))//bottom left curve
        path.addQuadCurve(to: CGPoint(x: centerWidth + 40, y: height - 10),
                          controlPoint: CGPoint(x: centerWidth + 40, y: height + 10))//bottom rigt curve
        path.addLine(to: CGPoint(x: centerWidth + 41, y: 20))// right vertical line
        path.addQuadCurve(to: CGPoint(x: centerWidth + 50, y: 0),
                                       controlPoint: CGPoint(x: centerWidth + 41, y: 5)) //top right curve
        path.addLine(to: CGPoint(x: self.tabBar.frame.width, y: -20))//right slope
                     
        //close the path
        path.addLine(to: CGPoint(x: self.tabBar.frame.width, y: self.tabBar.frame.height + 50))
        path.addLine(to: CGPoint(x: 0, y: self.tabBar.frame.height + 50))
        path.close()
        return path.cgPath
    }
}
