//
//  LoadingButton.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.02.2024.
//

import UIKit

final class LoadingButton: UIButton {
    
    var indicatorColor : UIColor = .systemBackground
    var originalButtonText: String?
    var activityIndicator: UIActivityIndicatorView?
    
    init(originalText: String, type: UIButton.ButtonType) {
        self.originalButtonText = originalText
        super.init(frame: .zero)
        self.setupLoginButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLoginButton() {
        self.tintColor = .systemBackground
        self.backgroundColor = .systemCyan
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.hideLoading()
        self.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.size.width / 8)
        }
    }
    
    func showLoading() {
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        DispatchQueue.main.async {
            self.showSpinning()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async(execute: {
            self.setTitle(self.originalButtonText, for: .normal)
            self.activityIndicator?.stopAnimating()
        })
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = indicatorColor
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator ?? UIActivityIndicatorView(style: .medium))
        centerActivityIndicatorInButton()
        activityIndicator?.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, 
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, 
                                                   attribute: .
                                                   centerY,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerY,
                                                   multiplier: 1,
                                                   constant: 0)
        self.addConstraint(yCenterConstraint)
    }
}
