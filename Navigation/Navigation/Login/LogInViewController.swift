//
//  LogInViewController.swift
//  Navigation
//
//  Created by Andrey Kaplun on 20/02/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit
import SwiftUI

final class LogInViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = self.view.bounds.size
        scrollView.contentSize.height = 506
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "logo.png"))
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
        
    private lazy var loginTextField: UITextField = {
        let textField = PaddingTextField(withLeftInset: 20)
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        textField.layer.cornerRadius = 10
        textField.textColor = .black
        textField.placeholder = "Email or phone"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.autocapitalizationType = .none
        textField.text = self.defaultLogin
        textField.addTarget(self, action: #selector(self.textFieldEditingDidEndOnExit), for: .editingDidEndOnExit)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = PaddingTextField(withLeftInset: 20)
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        textField.layer.cornerRadius = 10
        textField.textColor = .black
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.text = self.defualtPassword
        textField.addTarget(self, action: #selector(self.textFieldEditingDidEndOnExit), for: .editingDidEndOnExit)
        textField.addTarget(self, action: #selector(self.textFieldEditingChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let colorSet = UIColor(hexString: "4885CC")

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = colorSet
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemRed
        label.isHidden = true
        label.text = "Password lenght must be at least \(self.minPasswordLenght) symbols"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let minPasswordLenght = 5
    private var loginButtonTopConstraint: NSLayoutConstraint?
    private var contentViewHeightConstraint: NSLayoutConstraint?
    
    private let defaultLogin = "user@net.ru"
    private let defualtPassword = "A1b2c3"
    private var isDefualtLogin: Bool {
        self.loginTextField.text == self.defaultLogin
    }
    private var isDefaultPassword: Bool {
        self.passwordTextField.text == self.defualtPassword
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true

        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        
        self.setupContentView()
        
        let margins = view.safeAreaLayoutGuide
        
        let scrollViewLeadingConstraint = scrollView.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let scrollViewTrailingConstraint = scrollView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        let scrollViewTopConstraint = scrollView.topAnchor.constraint(equalTo: margins.topAnchor)
        let scrollViewBottonConstraint = scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        
        let contentViewTopConstraint = self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor)
        let contentViewCenterXConstraint = self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let contentViewWidthConstraint = self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        self.contentViewHeightConstraint = self.contentView.heightAnchor.constraint(equalToConstant: 506)
        
        NSLayoutConstraint.activate([
            scrollViewLeadingConstraint, scrollViewTrailingConstraint,
            scrollViewTopConstraint, scrollViewBottonConstraint,
            contentViewTopConstraint, contentViewCenterXConstraint,
            contentViewWidthConstraint, self.contentViewHeightConstraint
            ].compactMap({ $0 }))

        self.registerForNotifications()
        
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        //self.view.addGestureRecognizer(tapGesture)
    }
    
    private func setScrollViewInset(inset: CGFloat = 0) {
        let inset = contentView.bounds.size.height - scrollView.bounds.size.height + inset
        scrollView.setContentOffset(CGPoint(x: 0, y: inset > 0 ? inset : 0), animated: true)
    }
    
    private func setupContentView() {
        contentView.addSubview(logoImageView)
        contentView.addSubview(loginTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(loginButton)
        
        let logoImageViewHeightConstraint = logoImageView.heightAnchor.constraint(equalToConstant: 100)
        let logoImageViewWidthConstraint = logoImageView.widthAnchor.constraint(equalToConstant: 100)
        let logoImageViewCenterXConstraint = logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120)
        
        let loginTextFieldHeightConstraint = loginTextField.heightAnchor.constraint(equalToConstant: 50)
        let loginTextFieldTopConstraint = loginTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120)
        let loginTextFieldLeadingConstraint = loginTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        let loginTextFieldTrailingConstraint = loginTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)

        let passwordTextFieldHeightConstraint = passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        let passwordTextFieldTopConstraint = passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: -0.5)
        let passwordTextFieldLeadingConstraint = passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        let passwordTextFieldTrailingConstraint = passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        
        let loginButtonHeightConsytaint = loginButton.heightAnchor.constraint(equalToConstant: 50)
        self.loginButtonTopConstraint = loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16)
        let loginButtonLeadingConstraint = loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        let loginButtonTrailingConstraint = loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        
        NSLayoutConstraint.activate([
            logoImageViewHeightConstraint, logoImageViewWidthConstraint,
            logoImageViewCenterXConstraint, logoImageViewTopConstraint,
            loginTextFieldHeightConstraint, loginTextFieldTopConstraint,
            loginTextFieldLeadingConstraint, loginTextFieldTrailingConstraint,
            passwordTextFieldHeightConstraint, passwordTextFieldTopConstraint,
            passwordTextFieldLeadingConstraint, passwordTextFieldTrailingConstraint,
            loginButtonHeightConsytaint, self.loginButtonTopConstraint,
            loginButtonLeadingConstraint, loginButtonTrailingConstraint
            ].compactMap({ $0 }))

    }
        
    @objc private func textFieldEditingDidEndOnExit(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        guard textField === self.passwordTextField else { return }
        if self.warningLabel.isHidden { return }
        if isPasswordValid() { self.passwordWarningToggle() }
    }

    @objc private func loginButtonPressed(_ button: UIButton) {
        if !self.loginTextField.hasText {
            let color = self.loginTextField.backgroundColor
            UIView.animate(withDuration: 0.2, animations: {
                self.loginTextField.backgroundColor = .systemRed
            }, completion: { _ in
                UIView.animate(withDuration: 0.2, animations: {
                    self.loginTextField.backgroundColor = color
                }, completion: nil)
            })
            return
        }
        
        if !self.passwordTextField.hasText {
            self.passwordTextField.layer.animateBorder(with: .systemRed, width: 2)
            return
        }
        
        if !self.isPasswordValid() {
            if self.warningLabel.isHidden { self.passwordWarningToggle() }
            return
        }
        
        if !isDefualtLogin || !isDefaultPassword {
            let alertController = UIAlertController(title: "Error", message: "The user name or password is not valid", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        let profileViewController = ProfileViewController()
        profileViewController.modalPresentationStyle = .automatic
        guard let navController = navigationController else { return }
        navController.pushViewController(profileViewController, animated: true)
    }
    
    private func registerForNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardDidShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardDidShown(notification: NSNotification) {
        let info = notification.userInfo
        if let keyboardRect = info?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect {
            self.setScrollViewInset(inset: keyboardRect.size.height)
        }
    }

    @objc private func keyboardDidHide(notification: NSNotification) {
        self.setScrollViewInset()
    }
    
    private func isPasswordValid() -> Bool {
        return (self.passwordTextField.text?.count ?? 0) >= self.minPasswordLenght
    }
    
    private func passwordWarningToggle() {
        if !self.contentView.subviews.contains(self.warningLabel) {
            self.contentView.addSubview(self.warningLabel)
            
            let topConstraint = self.warningLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16)
            let leadingConstraint = self.warningLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
            let trailingConstraint = self.warningLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            
            NSLayoutConstraint.activate([
                topConstraint,
                leadingConstraint,
                trailingConstraint
            ])
        }
        self.warningLabel.isHidden.toggle()
        [self.loginButtonTopConstraint, self.contentViewHeightConstraint].compactMap({ $0 }).forEach({
            $0.constant += self.warningLabel.isHidden ? -30 : 30
        })
    }
}
