//
//  CustomAlertController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 25.04.2024.
//

import UIKit

protocol AlertControllerDelegate: AnyObject {
    func dismissMe()
}

final class CustomAlertController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        modalTransitionStyle = .crossDissolve
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
    }

    func present(type: CustomAlertType, title: String, message: String, imageName: String, colorOne: UIColor, colorTwo: UIColor?, buttonText: String,
                 buttonTextTwo: String?, handler: @escaping (Bool) -> Void) {
        let alertView = CustomAlertView(type: type, title: title, message: message, image: UIImage(named: imageName)!, colorOne: colorOne, colorTwo: colorTwo,
                                        buttonTitleOne: buttonText, buttonTitleTwo: buttonTextTwo, closure: handler)
        alertView.delegate = self
        view.addSubview(alertView)
        alertView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension CustomAlertController: AlertControllerDelegate {
    func dismissMe() {
        self.dismiss(animated: true, completion: nil)
    }
}
