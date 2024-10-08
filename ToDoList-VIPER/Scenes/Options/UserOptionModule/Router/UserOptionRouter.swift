//
//  UserOptionRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 05.07.2024.
//

import UIKit

final class UserOptionRouter: UserOptionRouterProtocol {

    weak var presenter: UserOptionPresenterProtocol?

    deinit {
           debugPrint("? deinit \(self)")
       }

    func goBack(from view: UserOptionViewProtocol) {
        guard let view = view as? UIViewController else { return }
        view.navigationController?.popViewController(animated: true)
    }

    func showImageSourceAlert(from view: UserOptionViewProtocol) {
        guard let registrationView = view as? UIViewController else { return }
        let allertController = UIAlertController(title: "Выберете источник",
                                                 message: "Выберете источник для аватара пользователя. Приложению понадобятся соответствующие разрешения",
                                                 preferredStyle: .alert)
        allertController.addAction(UIAlertAction(title: "Камера",
                                                 style: .default,
                                                 handler: {_ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.goToImagePicker(from: view, status: .camera)
            } else {
                self.presenter?.checkPermission(with: .camera)
            }
        }))
        allertController.addAction(UIAlertAction(title: "Галлерея",
                                                 style: .default,
                                                 handler: {_ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.goToImagePicker(from: view, status: .gallery)
            } else {
                self.presenter?.checkPermission(with: .gallery)
            }
        }))
        allertController.addAction(UIAlertAction(title: "Позже",
                                                 style: .cancel,
                                                 handler: {_ in }))
        registrationView.present(allertController, animated: true)
    }

    func goToOption(from view: UserOptionViewProtocol, with label: String) {
        guard let registrationView = view as? UIViewController else { return }
        let alert = UIAlertController(title: "Открыть настройки",
                                      message: "Доступ к \(label) не предоставлен. Открыть настройки для предоставления доступа?",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Открыть настройки", style: .default, handler: { _ in
            UIApplication.shared.open(NSURL(string: UIApplication.openSettingsURLString)! as URL, options: [:], completionHandler: nil)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        registrationView.present(alert, animated: true)
    }

    func goToImagePicker(from view: UserOptionViewProtocol, status: PermissionStatus) {
        guard let registrationView = view as? UIViewController else { return }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = registrationView as? any UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.allowsEditing = true
        switch status {
        case .camera:
            imagePicker.sourceType = .camera
            registrationView.present(imagePicker, animated: true, completion: nil)
        case .gallery:
            DispatchQueue.main.async {
                imagePicker.sourceType = .photoLibrary
                registrationView.present(imagePicker, animated: true, completion: nil)
            }
        }
    }
}
