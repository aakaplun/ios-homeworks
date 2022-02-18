//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Andrey Kaplun on 12/02/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {

    lazy var photoView: UIImageView = {
        let photoView = UIImageView(image:  #imageLiteral(resourceName: "cat.png"))
        photoView.layer.borderColor = UIColor.white.cgColor
        photoView.layer.borderWidth = 3
        photoView.layer.cornerRadius = 50
        photoView.clipsToBounds = true
        photoView.translatesAutoresizingMaskIntoConstraints = false
        return photoView
    }()
    
    lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "Hipster Cat"
        textLabel.font = UIFont.boldSystemFont(ofSize: 18)
        textLabel.textColor = .black
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "Waiting for something..."
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.textColor = .gray
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    lazy var statusField: TextField = {
        let statusField = TextField()
        statusField.placeholder = "Введите текст"
        statusField.backgroundColor = .white
        statusField.font = UIFont.systemFont(ofSize: 15)
        statusField.textColor = .black
        statusField.layer.cornerRadius = 12
        statusField.layer.borderWidth = 1
        statusField.layer.borderColor = UIColor.black.cgColor
        statusField.returnKeyType = UIReturnKeyType.done
        statusField.clearButtonMode = UITextField.ViewMode.whileEditing
        statusField.text = statusLabel.text
        statusField.translatesAutoresizingMaskIntoConstraints = false

        statusField.addTarget(self, action: #selector(statusFieldDidBeginEditing), for: .editingDidBegin)
        statusField.addTarget(self, action: #selector(statusFieldDidEndEditing), for: .editingDidEnd)
        statusField.addTarget(self, action: #selector(statusFieldTextChanged), for: .editingChanged)
        statusField.addTarget(self, action: #selector(statusFieldEditingDidEndOnExit), for: .editingDidEndOnExit)
        return statusField
    }()
    
    lazy var statusButton: UIButton = {
        let statusButton = UIButton()
        statusButton.titleLabel?.textColor = .white
        statusButton.layer.cornerRadius = 4
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOpacity = 0.7
        statusButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        return statusButton
    }()
    
    private var statusButtonTopConstraint: NSLayoutConstraint?
       
    enum Status {
        case isGet
        case isSet
    }
    
    private var status: Status = .isGet {
        didSet {
            statusButton.setTitle(statusButtonText, for: .normal)
            statusField.isHidden = status == .isGet
        }
    }
    
    private var statusButtonText: String {
        switch status {
        case Status.isGet:
            return "Get status"
        case Status.isSet:
            return "Set status"
        }
    }
    
    private var statusText: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
    }
    
    private func viewInit() {

        self.addSubview(photoView)
        self.addSubview(textLabel)
        self.addSubview(statusLabel)
        self.addSubview(statusField)
        self.addSubview(statusButton)
        
        status = .isGet
        self.setStatusButton()

        let margins = self.safeAreaLayoutGuide
        let photoViewHeightConstraint = photoView.heightAnchor.constraint(equalToConstant: 100)
        let photoViewWidthConstraint = photoView.widthAnchor.constraint(equalToConstant: 100)
        let photoViewLeadingConstraint = photoView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16)
        let photViewTopConstraint = photoView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 16)
        
        let textLabelLeadingConstraint = textLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 20)
        let textLabelTopConstraint = textLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 27)
        let textLabelTrailingConstraint = textLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16)

        let statusLabelLeadingConstraint = statusLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 20)
        let statusLabelTopAncor = statusLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 27)
        let statusLabelTrailingConstraint = statusLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16)
        
        let statusFieldHeightConstraint = statusField.heightAnchor.constraint(equalToConstant: 40)
        let statusFieldTopConstraint = statusField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16)
        let statusFieldLeadingConstraint = statusField.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 20)
        let statusFieldTrailingConstraint = statusField.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16)
 
        let statusButtonHeightConstraint = statusButton.heightAnchor.constraint(equalToConstant: 50)
        //let statusButtonTopConstraint = statusButton.topAnchor.constraint(equalTo: statusField.bottomAnchor, constant: 16)
        let statusButtonLeadingConstraint = statusButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16)
        let statusButtonTrailingConstraint = statusButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16)

        NSLayoutConstraint.activate([photoViewHeightConstraint, photoViewWidthConstraint,
                                     photoViewLeadingConstraint, photViewTopConstraint,
                                     textLabelLeadingConstraint, textLabelTopConstraint, textLabelTrailingConstraint,
                                     statusLabelLeadingConstraint, statusLabelTopAncor, statusLabelTrailingConstraint,
                                     statusFieldHeightConstraint, statusFieldTopConstraint,
                                     statusFieldLeadingConstraint, statusFieldTrailingConstraint,
                                     statusButtonHeightConstraint,
            statusButtonLeadingConstraint, statusButtonTrailingConstraint
            ].compactMap({ $0 }))
        setStatusButtonTopConstraint()
    }
    
    @objc func statusButtonPressed(_ button: UIButton) {
        switch status {
        case .isSet:
            statusField.resignFirstResponder()
        case .isGet:
            statusField.becomeFirstResponder()
        }
        setStatusButtonTopConstraint()
    }
    
    // statusField Actions
    @objc func statusFieldDidBeginEditing(_ textField: UITextField) {
        status = .isSet
        self.setStatusButton()
    }
    
    @objc func statusFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        statusLabel.text = text
        status = .isGet
    }
    
    @objc func statusFieldTextChanged(_ textField: UITextField) {
        self.setStatusButton()
        statusText = textField.text ?? ""
    }
    
    @objc func statusFieldEditingDidEndOnExit(_ textField: UITextField) {
        textField.resignFirstResponder()
        setStatusButtonTopConstraint()
    }
    
    private func setStatusButton() {
        let isEnabled = !(statusField.text == "") || status == .isGet
        statusButton.isEnabled = isEnabled
        statusButton.backgroundColor = isEnabled ? .systemBlue : .lightGray
    }
    
    private func setStatusButtonTopConstraint() {
        NSLayoutConstraint.deactivate([statusButtonTopConstraint].compactMap({ $0 }))
        switch status {
        case .isGet:
            statusButtonTopConstraint = statusButton.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 16)
        case .isSet:
            statusButtonTopConstraint = statusButton.topAnchor.constraint(equalTo: statusField.bottomAnchor, constant: 16)
        }
        NSLayoutConstraint.activate([statusButtonTopConstraint].compactMap({ $0 }))
    }
}

class TextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 15)
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
