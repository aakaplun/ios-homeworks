//
//  PostViewController.swift
//  Navigation
//
//  Created by Andrey Kaplun on 10/02/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    //var post = Post(title: "")
    var post = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .green
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        self.view.addSubview(navBar)
        
        let navItem = UINavigationItem()
        navItem.title = self.post //.title
        navItem.rightBarButtonItem = UIBarButtonItem(title: "Инфо", style: .plain, target: self, action: #selector(infoButtonAction))
        navBar.setItems([navItem], animated: true)
    }
    
    @objc func infoButtonAction(sender: UIButton!) {
        let infoViewController = InfoViewController()
        infoViewController.modalPresentationStyle = .automatic
        self.present(infoViewController, animated: true, completion: nil)
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
