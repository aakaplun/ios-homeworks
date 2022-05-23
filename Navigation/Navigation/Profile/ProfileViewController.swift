//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Andrey Kaplun on 10/02/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    internal lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 198
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileHeaderView")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private func tableViewConstraints() -> [NSLayoutConstraint] {
        let margins = self.view.safeAreaLayoutGuide
        let topConstraint = self.tableView.topAnchor.constraint(equalTo: margins.topAnchor)
        let bottomConstraint = self.tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        let leadingConstraint = self.tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = self.tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        return [topConstraint, bottomConstraint, leadingConstraint, trailingConstraint]
    }
    
    private var headerViewHeaderHeight: CGFloat = 198
    
    internal lazy var avatarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var collapseAvatarCode = {}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.tableView)
        
        let tableViewConstraints = self.tableViewConstraints()
        
        NSLayoutConstraint.activate(tableViewConstraints)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as? PhotosTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        let post = posts[indexPath.row]
        cell.setup(with: post)
        let likeTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.addLike))
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.showPost))
        cell.setGestures(likeTapGesture, imageTapGesture, for: indexPath)
        cell.selectionStyle = .none
        
        return cell
    }

    @objc private func addLike(sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel else { return }
        posts[label.tag].likes += 1
        let indexPath = IndexPath(row: label.tag, section: 1)
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    @objc private func showPost(sender: UITapGestureRecognizer) {
        guard let image = sender.view as? UIImageView else { return }
        
        let detailViewController = DetailViewController()
        detailViewController.setup(with: posts[image.tag])
        detailViewController.view.backgroundColor = .white
        self.present(detailViewController, animated: true) {
            let indexPath = IndexPath(row: image.tag, section: 1)
            posts[image.tag].views += 1
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section > 0 {return nil}
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeaderView") as? ProfileHeaderView else {
            return nil
        }
        view.delegate = self
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 0 {return 0}
        return self.headerViewHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0, let navController = navigationController {
            let photosViewController = PhotosViewController()
            navController.pushViewController(photosViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0
    }
}

extension ProfileViewController: ProfileHeaderViewDelegate {
    func setHeaderViewHeight(_ height: CGFloat) {
        self.headerViewHeaderHeight = height
    }
    
    func beginUpdates() {
        self.tableView.beginUpdates()
    }
    
    func endUpdates() {
        self.tableView.endUpdates()
    }
}
