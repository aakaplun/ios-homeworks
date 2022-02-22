//
//  LogInViewController.swift
//  Navigation
//
//  Created by Andrey Kaplun on 20/02/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

final class LogInViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = self.view.bounds.size
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let colorSet = UIColor(hexString: "#4885CC")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true

        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        
        setupConstraints()
        setupContentView()
    }
    
    private func setupConstraints() {
        let margins = view.safeAreaLayoutGuide
        
        let scrollViewLeadingConstraint = scrollView.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let scrollViewTrailingConstraint = scrollView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        let scrollViewTopConstraint = scrollView.topAnchor.constraint(equalTo: margins.topAnchor)
        let scrollViewBottonConstraint = scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        
        let contentViewTopConstraint = self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor)
        let contentViewCenterXConstraint = self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let contentViewWidthConstraint = self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        let contentViewHeightConstraint = self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor)

        NSLayoutConstraint.activate([
            scrollViewLeadingConstraint, scrollViewTrailingConstraint,
            scrollViewTopConstraint, scrollViewBottonConstraint,
            contentViewTopConstraint, contentViewCenterXConstraint,
            contentViewWidthConstraint, contentViewHeightConstraint
        ])
    }

    private func setupContentView() {
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "logo.png"))
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let loginTableView = UITableView()
        loginTableView.estimatedRowHeight = 50
        loginTableView.layer.borderColor = UIColor.lightGray.cgColor
        loginTableView.layer.borderWidth = 0.5
        loginTableView.layer.cornerRadius = 10
        loginTableView.delegate = self
        loginTableView.dataSource = self
        loginTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        loginTableView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(loginTableView)
        contentView.addSubview(loginButton)
        
        let logoImageViewHeightConstraint = logoImageView.heightAnchor.constraint(equalToConstant: 100)
        let logoImageViewWidthConstraint = logoImageView.widthAnchor.constraint(equalToConstant: 100)
        let logoImageViewCenterXConstraint = logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120)
        
        let loginTableViewHeightConstraint = loginTableView.heightAnchor.constraint(equalToConstant: 100)
        let loginTableViewTopConstraint = loginTableView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120)
        let loginTableViewLeadingConstraint = loginTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        let loginTableViewTrailingConstraint = loginTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        
        let loginButtonHeightConsytaint = loginButton.heightAnchor.constraint(equalToConstant: 50)
        let loginButtonTopConstraint = loginButton.topAnchor.constraint(equalTo: loginTableView.bottomAnchor, constant: 16)
        let loginButtonLeadingConstraint = loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        let loginButtonTrailingConstraint = loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)

        NSLayoutConstraint.activate([
            logoImageViewHeightConstraint, logoImageViewWidthConstraint,
            logoImageViewCenterXConstraint, logoImageViewTopConstraint,
            loginTableViewHeightConstraint, loginTableViewTopConstraint,
            loginTableViewLeadingConstraint, loginTableViewTrailingConstraint,
            loginButtonHeightConsytaint, loginButtonTopConstraint,
            loginButtonLeadingConstraint, loginButtonTrailingConstraint
        ])

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        let cell = UITableViewCell()
        
        let textField = PaddingTextField(withLeftInset: 20)
        textField.backgroundColor = .lightGray
        textField.textColor = .black
        textField.placeholder = indexPath.row == 0 ? "Email or phone" : "Password"
        textField.tag = indexPath.row
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.autocapitalizationType = .none
        //textField.tintColor = accentColor
        textField.isSecureTextEntry = indexPath.row == 1
        textField.text = ""
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        cell.addSubview(textField)
        
        let topConstraint = textField.topAnchor.constraint(equalTo: cell.topAnchor)
        let bottomConstraint = textField.bottomAnchor.constraint(equalTo: cell.bottomAnchor)
        let leadingConstraint = textField.leadingAnchor.constraint(equalTo: cell.leadingAnchor)
        let trailingConstraint = textField.trailingAnchor.constraint(equalTo: cell.trailingAnchor)
        NSLayoutConstraint.activate([
            topConstraint, bottomConstraint, leadingConstraint, trailingConstraint
        ])
        
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(textFieldTextChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldEditingDidEndOnExit), for: .editingDidEndOnExit)

        return cell
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    @objc func textFieldTextChanged(_ textField: UITextField) {
    }
    
    @objc func textFieldEditingDidEndOnExit(_ textField: UITextField) {
        textField.resignFirstResponder()
    }

    @objc func loginButtonPressed(_ button: UIButton) {
    }

}
