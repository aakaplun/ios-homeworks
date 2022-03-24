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
        textField.text = ""
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
        textField.text = ""
        textField.addTarget(self, action: #selector(self.textFieldEditingDidEndOnExit), for: .editingDidEndOnExit)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true

        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        
        setupContentView()
        
        let margins = view.safeAreaLayoutGuide
        
        let scrollViewLeadingConstraint = scrollView.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let scrollViewTrailingConstraint = scrollView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        let scrollViewTopConstraint = scrollView.topAnchor.constraint(equalTo: margins.topAnchor)
        let scrollViewBottonConstraint = scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        
        let contentViewTopConstraint = self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor)
        let contentViewCenterXConstraint = self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let contentViewWidthConstraint = self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        let contentViewHeightConstraint = self.contentView.heightAnchor.constraint(equalToConstant: 506)
        
        NSLayoutConstraint.activate([
            scrollViewLeadingConstraint, scrollViewTrailingConstraint,
            scrollViewTopConstraint, scrollViewBottonConstraint,
            contentViewTopConstraint, contentViewCenterXConstraint,
            contentViewWidthConstraint, contentViewHeightConstraint
        ])

        registerForNotifications()
        
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        //self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setScrollViewInset()
    }
    
    private func setScrollViewInset(inset: CGFloat = 0) {
        let inset = contentView.bounds.size.height - scrollView.bounds.size.height + inset
        if inset >= 0 {
            scrollView.setContentOffset(CGPoint(x: 0, y: inset), animated: true)
        }
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
        let loginButtonTopConstraint = loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16)
        let loginButtonLeadingConstraint = loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        let loginButtonTrailingConstraint = loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        
        NSLayoutConstraint.activate([
            logoImageViewHeightConstraint, logoImageViewWidthConstraint,
            logoImageViewCenterXConstraint, logoImageViewTopConstraint,
            loginTextFieldHeightConstraint, loginTextFieldTopConstraint,
            loginTextFieldLeadingConstraint, loginTextFieldTrailingConstraint,
            passwordTextFieldHeightConstraint, passwordTextFieldTopConstraint,
            passwordTextFieldLeadingConstraint, passwordTextFieldTrailingConstraint,
            loginButtonHeightConsytaint, loginButtonTopConstraint,
            loginButtonLeadingConstraint, loginButtonTrailingConstraint
        ])

    }
        
    @objc func textFieldEditingDidEndOnExit(_ textField: UITextField) {
        textField.resignFirstResponder()
    }

    @objc func loginButtonPressed(_ button: UIButton) {
        let profileViewController = ProfileViewController()
        profileViewController.modalPresentationStyle = .automatic
        self.present(profileViewController, animated: true, completion: nil)
    }
    
    func registerForNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardDidShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardDidShown(notification: NSNotification) {
        let info = notification.userInfo
        if let keyboardRect = info?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect {
            self.setScrollViewInset(inset: keyboardRect.size.height)
        }
    }

    @objc func keyboardDidHide(notification: NSNotification) {
        self.setScrollViewInset()
    }
}
