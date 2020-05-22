//
//  TabBarViewController.swift
//  SearchPhotoDemo
//
//  Created by Judy on 2020/5/22.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    static let storyBoardID = "TabBarViewController"
    
    fileprivate let itemName: [String] = ["album", "favorite"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItem()
    }
    
    fileprivate func setupItem() {
        var items: [UIViewController] = []
        if let albumVC = storyboard?.instantiateViewController(withClass: SearchViewController.self){
            let nv = UINavigationController(rootViewController: albumVC)
            nv.tabBarItem.title = itemName[0]
            items.append(nv)
        }
        
        let favoriteVC = FavoriteCollectionViewController(nibName: FavoriteCollectionViewController.nibName, bundle: nil)
        favoriteVC.tabBarItem.title = itemName[1]
        items.append(favoriteVC)
        
        viewControllers = items
    }
}
