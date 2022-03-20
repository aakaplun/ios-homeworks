//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Andrey Kaplun on 10/02/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 200
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileHeaderView")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var posts: [Post] = {
        var posts = [Post]()
        posts.append(Post(autor: "Нетология. Меняем карьеру через образование",
                          description: "В Медиа рассказали, когда нужен и как работает судебный PR, какие каналы используют специалисты и с какими заблуждениями сталкиваются → https://netolo.gy/hHV",
                          image: "Netology1", likes: 100, views: 500))
        posts.append(Post(autor: "Нетология. Меняем карьеру через образование",
                          description: "14 марта стартует бесплатный курс «Основы вёрстки сайта». HTML и CSS — служат основой каждого сайта, соцсети или интернет-магазина, которыми мы пользуемся каждый день. Знать их полезно не только веб-разработчикам, но и всем, кто работает с вебом — дизайнерам, контент-менеджерам, интернет-маркетологам и руководителям проектов. На курсе вы выполните 16 практических заданий и научитесь самостоятельно вносить изменения в HTML-код, верстать с нуля текстовые блоки, менять внешний вид отдельных элементов сайта с помощью CSS, а также готовить контент для публикации на сайте. Регистрируйтесь → https://netolo.gy/hHL",
                          image: "Netology2"))
        posts.append(Post(autor: "Нетология. Меняем карьеру через образование",
                          description: "🚀 Запустили бесплатный курс «Аналитика для начинающих интернет-маркетологов». Веб-аналитика помогает правильно выбрать каналы продвижения, а после рекламной кампании ― сделать выводы и оптимизировать расходы. Курс состоит из коротких уроков и практических кейсов, чтобы учиться было интересно и знания лучше усваивались. Вы увидите, как работает аналитика в действии и как можно развивать проект или продукт при помощи данных. Записывайтесь, начать можно в любое удобное время → https://netolo.gy/hHb",
                          image: "Netology3"))
        posts.append(Post(autor: "Нетология. Меняем карьеру через образование",
                          description: "🤖 28 февраля стартует бесплатный курс «Искусственный интеллект: создайте свою первую нейросеть». Благодаря машинному обучению нам доступны чудеса вроде распознавания лиц, написания песен в стиле «Гражданской обороны» и картин в духе Рембрандта. Создать свою собственную нейросеть реально — и не только для опытных дата-сайентистов. Вы тоже можете попробовать. Вы узнаете, как устроены нейросети и в каких сферах они применяются, а также самостоятельно обучите до 4-х математических моделей. Мир Data Science и искусственного интеллекта — доступнее, чем кажется. Убедитесь в этом сами → https://netolo.gy/hFG",
                          image: "Netology4"))
        return posts
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableView)
        let margins = self.view.safeAreaLayoutGuide
        let topConstraint = tableView.topAnchor.constraint(equalTo: margins.topAnchor)
        let bottomConstraint = tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        let leadingConstraint = tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        NSLayoutConstraint.activate([
            topConstraint,
            bottomConstraint,
            leadingConstraint,
            trailingConstraint
        ])
        
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.posts.count
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
        let post = self.posts[indexPath.row]
        cell.setup(with: post)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section > 0 {return nil}
        //let view = ProfileHeaderView()
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeaderView") else {
            return nil
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0, let navController = navigationController {
            let photosViewController = PhotosViewController()
            navController.pushViewController(photosViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
