//
//  RegistrationRouter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.01.2024.
//

import UIKit

final class RegistrationRouter: RegistrationRouterProtocol {
    var presenter: RegistrationPresenterPtorocol?
    
    static func createRegistrationModule() -> UIViewController {
        let view = RegistrationController()
        let presenter: RegistrationPresenterPtorocol & RegistrationInteractorOutputProtocol = RegistrationPresenter()
        let interactor: RegistrationInteractorInputProtocol = RegistrationInteractor()
        let router: RegistrationRouterProtocol = RegistrationRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.presenter = presenter
        return view
    }
    
    //MARK: - Alert method to show allert with registration status
    func showAlert(with result: RegistrationStatus, and view: RegistrationViewProtocol) {
        let alertController = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        guard let view = view as? UIViewController else { return }
        switch result {
        case .complete:
            alertController.title = "Регистрация прошла успешно!"
            alertController.addAction(UIAlertAction(title: "Ок", style: .default, handler: { _ in
                view.navigationController?.popViewController(animated: true)
            }))
            view.present(alertController, animated: true)
        case .connectionLost:
            alertController.title = "Проеврьте соединение с интернетом"
            alertController.addAction(UIAlertAction(title: "Ок", style: .cancel))
            view.present(alertController, animated: true)
        case .notValidEmail:
            alertController.title = "Введен неверный адрес электронной почты. Пожалуйста, попробуйте снова"
            alertController.addAction(UIAlertAction(title: "Ок", style: .cancel))
            view.present(alertController, animated: true)
        case .emptyFields:
            alertController.title = "Вы не заполнили обязательные для регистрации поля"
            alertController.addAction(UIAlertAction(title: "Ок", style: .cancel))
            view.present(alertController, animated: true)
        case .error:
            alertController.title = "Обнаружена неизвестная ошибка. Пожалуйста, попробуйте снова"
            alertController.addAction(UIAlertAction(title: "Ок", style: .cancel))
            view.present(alertController, animated: true)
        }
    }
    
    //MARK: - Alert for choose avatar source
    func showImageSourceAlert(from view:  RegistrationViewProtocol) {
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
            } else  {
                self.presenter?.checkPermission(with: .gallery)
            }
           
        }))
        allertController.addAction(UIAlertAction(title: "Позже",
                                                 style: .cancel,
                                                 handler: {_ in }))
        registrationView.present(allertController, animated: true)
    }
    
    //MARK: - Go to the options for permission method
    func goToOption(from view: any RegistrationViewProtocol, with label: String) {
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
    
    //MARK: - Present ImagePicker method
    func goToImagePicker(from view: any RegistrationViewProtocol, status: PermissionStatus) {
        guard let registrationView = view as? UIViewController else { return }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = registrationView as? any UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.allowsEditing = true
        switch status {
        case .camera:
            imagePicker.sourceType = .camera;
            registrationView.present(imagePicker, animated: true, completion: nil)
        case .gallery:
            DispatchQueue.main.async {
                imagePicker.sourceType = .photoLibrary;
                registrationView.present(imagePicker, animated: true, completion: nil)
            }
        }
    }
}
