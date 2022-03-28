//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Andrey Kaplun on 12/02/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    var delegate: ProfileViewController?

    lazy var avatarImageView: UIImageView = {
        let photoView = UIImageView(image: #imageLiteral(resourceName: "cat.png"))
        photoView.layer.borderColor = UIColor.white.cgColor
        photoView.layer.borderWidth = 3
        photoView.layer.cornerRadius = 50
        photoView.clipsToBounds = true
        photoView.translatesAutoresizingMaskIntoConstraints = false
        return photoView
    }()
    
    lazy var fullNameLabel: UILabel = {
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
    
    lazy var statusTextField: PaddingTextField = {
        let statusField = PaddingTextField()
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
    
    lazy var setStatusButton: UIButton = {
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
            setStatusButton.setTitle(statusButtonText, for: .normal)
            statusTextField.isHidden = status == .isGet
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
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.viewInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.viewInit()
    }
  
    private func viewInit() {

        self.addSubview(avatarImageView)
        self.addSubview(fullNameLabel)
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)
        self.addSubview(setStatusButton)
        
        self.status = .isGet
        self.setStatusButtonEnabled()

        let margins = self.safeAreaLayoutGuide
        let photoViewHeightConstraint = avatarImageView.heightAnchor.constraint(equalToConstant: 100)
        let photoViewWidthConstraint = avatarImageView.widthAnchor.constraint(equalToConstant: 100)
        let photoViewLeadingConstraint = avatarImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16)
        let photViewTopConstraint = avatarImageView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 16)
        
        let textLabelLeadingConstraint = fullNameLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 136)
        let textLabelTopConstraint = fullNameLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 27)
        let textLabelTrailingConstraint = fullNameLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16)

        let statusLabelLeadingConstraint = statusLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 136)
        let statusLabelTopAncor = statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 27)
        let statusLabelTrailingConstraint = statusLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16)
        
        let statusFieldHeightConstraint = statusTextField.heightAnchor.constraint(equalToConstant: 40)
        let statusFieldTopConstraint = statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16)
        let statusFieldLeadingConstraint = statusTextField.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 136)
        let statusFieldTrailingConstraint = statusTextField.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16)
 
        let statusButtonHeightConstraint = setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        let statusButtonBottonConstraint = setStatusButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -16)
        statusButtonBottonConstraint.priority = .defaultLow
        let statusButtonLeadingConstraint = setStatusButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16)
        let statusButtonTrailingConstraint = setStatusButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16)

        NSLayoutConstraint.activate([photoViewHeightConstraint, photoViewWidthConstraint,
                                     photoViewLeadingConstraint, photViewTopConstraint,
                                     textLabelLeadingConstraint, textLabelTopConstraint, textLabelTrailingConstraint,
                                     statusLabelLeadingConstraint, statusLabelTopAncor, statusLabelTrailingConstraint,
                                     statusFieldHeightConstraint, statusFieldTopConstraint,
                                     statusFieldLeadingConstraint, statusFieldTrailingConstraint,
                                     statusButtonHeightConstraint, statusButtonBottonConstraint,
                                     statusButtonLeadingConstraint, statusButtonTrailingConstraint
            ].compactMap({ $0 }))
        self.setStatusButtonTopConstraint()
        
        [self, self.avatarImageView].forEach {
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(_:))))
        }
    }
        
    @objc private func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard gestureRecognizer.view === self else {
            guard gestureRecognizer.view === self.avatarImageView else {return}
            // Avatar tapped
            print("Avatar tapped")
            return
        }
        // View tapped
        if self.status == .isGet {return}
        self.statusTextField.text = self.statusLabel.text
        self.statusTextField.resignFirstResponder()
        self.setStatusButtonEnabled()
    }
    
    @objc func statusButtonPressed(_ button: UIButton) {
        switch status {
        case .isSet:
            statusTextField.resignFirstResponder()
        case .isGet:
            statusTextField.becomeFirstResponder()
        }
    }
    
    // statusField Actions
    @objc func statusFieldDidBeginEditing(_ textField: UITextField) {
        self.status = .isSet
        self.setStatusButtonEnabled()
        self.updateTableView()
    }
    
    @objc func statusFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            self.statusText = text
            //textField.text = ""
            self.statusLabel.text = text
        }
        self.status = .isGet
        self.updateTableView()
    }

    @objc func statusFieldTextChanged(_ textField: UITextField) {
        self.setStatusButtonEnabled()
        statusText = textField.text ?? ""
    }

    @objc func statusFieldEditingDidEndOnExit(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    private func setStatusButtonEnabled() {
        let isEnabled = !(statusTextField.text == "") || status == .isGet
        self.setStatusButton.isEnabled = isEnabled
        self.setStatusButton.backgroundColor = isEnabled ? .systemBlue : .lightGray
        self.statusTextField.enablesReturnKeyAutomatically = isEnabled
    }

    private func setStatusButtonTopConstraint() {
        NSLayoutConstraint.deactivate([statusButtonTopConstraint].compactMap({ $0 }))
        switch self.status {
        case .isGet:
            self.statusButtonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 132)
        case .isSet:
            self.statusButtonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 16)
        }
        NSLayoutConstraint.activate([self.statusButtonTopConstraint].compactMap({ $0 }))
    }
    
    private func updateTableView() {
        self.delegate?.isHeaderViewExpanded = status == .isSet
        self.delegate?.tableView.beginUpdates()
        self.setStatusButtonTopConstraint()
        self.delegate?.tableView.endUpdates()
    }
}
