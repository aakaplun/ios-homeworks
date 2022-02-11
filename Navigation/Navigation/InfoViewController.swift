//
//  InfoViewController.swift
//  Navigation
//
//  Created by Andrey Kaplun on 11/02/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red

        let button = UIButton(type: .roundedRect)
        
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        button.setTitle("  Alert  ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(alertButtonAction), for: .touchUpInside)

        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        let centerY = button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0)
        
        NSLayoutConstraint.activate([centerX, centerY])
    }
    
    @objc func alertButtonAction(sender: UIButton!) {
        let alertController = UIAlertController(title: "Вопрос", message: "Чего хотим?", preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action) -> Void in
            print(action.title ?? "")
        })
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) -> Void in
            print(action.title ?? "")
        })
        alertController.addAction(cancelAction)
        
        //let constraints = view.constraints
        //NSLayoutConstraint.deactivate(constraints)
        
        self.present(alertController, animated: true, completion: nil)
        //NSLayoutConstraint.activate(constraints)
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
