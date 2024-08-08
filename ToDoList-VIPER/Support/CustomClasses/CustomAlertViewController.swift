//
//  CustomAlertViewController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 24.04.2024.
//

import UIKit

final class CustomAlertViewController {
    // MARK: - Outlets
    private let backgroundView: UIView =  {
       let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()

    private let alertView: UIView = {
       let alertView = UIView()
        alertView.backgroundColor = .systemBackground
        alertView.layer.masksToBounds = true
        alertView.layer.cornerRadius = 12
        return alertView
    }()

    func showAlert(with title: String, message: String, on viewController: UIViewController) {
        guard let targetView = viewController.view else { return }
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        targetView.addSubview(alertView)
        UIView.animate(withDuration: 0.25) {
            self.backgroundView.alpha = 0.6
        }
    }

    func dismissAlert() {

    }
}
