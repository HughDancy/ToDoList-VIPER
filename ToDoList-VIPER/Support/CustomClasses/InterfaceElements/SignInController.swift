//
//  SignInController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.02.2024.
//

import UIKit

class SingInController: UIViewController {

    // MARK: - OUTLETS
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200)
        subscribeKeyboardEvents()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        scrollView.keyboardDismissMode = .interactive
        setupHierarchy()
        setupLayout()
        view.layoutIfNeeded()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Setup Outlets
    func setupHierarchy() {
        view.addSubview(scrollView)
    }

    func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height)
        }
    }

    // MARK: - ScrollView keyboard functions
    func subscribeKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard let ksp = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        DispatchQueue.main.async {
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ksp.height - self.view.safeAreaInsets.bottom + 110, right: 0)
        }
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        scrollView.contentInset = .zero
    }
}

// MARK: - TextField Delegate
extension SingInController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1

        if let nextResponder = self.view.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
