//
//  FeedViewController.swift
//  Navigation
//
//  Created by Andrey Kaplun on 10/02/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

/*
struct Post {
    var title: String
}
*/
class FeedViewController: UIViewController {

    let post = "Пост" //Post(title: "Пост")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        self.view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let insets = view.safeAreaLayoutGuide
        let stackViewCenterXConstraint = stackView.centerXAnchor.constraint(equalTo: insets.centerXAnchor)
        let stackViewCenterYConstraint = stackView.centerYAnchor.constraint(equalTo: insets.centerYAnchor)
        let stackViewWidth = stackView.widthAnchor.constraint(equalToConstant: 400)
        let stackViewHeight = stackView.heightAnchor.constraint(equalToConstant: 200)

        NSLayoutConstraint.activate([stackViewCenterXConstraint, stackViewCenterYConstraint,
                                     stackViewWidth, stackViewHeight])
        
        let button1 = UIButton()
        button1.layer.cornerRadius = 12
        stackView.addArrangedSubview(button1)
        button1.backgroundColor = .systemBlue
        button1.addTarget(self, action: #selector(postButtonAction), for: .touchUpInside)
        
        let button2 = UIButton()
        button2.layer.cornerRadius = 12
        stackView.addArrangedSubview(button2)
        button2.backgroundColor = .systemRed
        button2.addTarget(self, action: #selector(postButtonAction), for: .touchUpInside)

/*
        let button = UIButton(type: .roundedRect)
        
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        button.setTitle("  Пост  ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(postButtonAction), for: .touchUpInside)

        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        let bottom = button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        
        NSLayoutConstraint.activate([bottom, centerX])
 */
    }
    
    @objc func postButtonAction(sender: UIButton!) {
        let postViewController = PostViewController()
        postViewController.post = self.post
        self.present(postViewController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
