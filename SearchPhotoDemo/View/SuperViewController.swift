//
//  SuperViewController.swift
//  SearchPhotoDemo
//
//  Created by Judy on 2020/5/21.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import UIKit

class SuperViewController: UIViewController {

    /// Use after super.viewDidLoad.
    var activityView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityView()
    }
    
    /// setup activity view (load view)
    private func setupActivityView() {
        activityView = UIActivityIndicatorView(frame: view.frame)
        activityView.style = .whiteLarge
        // 設定 subview
        let width = activityView.frame.width * 0.3
        let subView = UIView(frame: CGRect(
            x: activityView.bounds.midX - width / 2,
            y: activityView.bounds.midY - width / 2,
            width: width,
            height: width)
        )
        subView.backgroundColor = .lightGray
        subView.layer.masksToBounds = true
        subView.layer.cornerRadius = 15
        
        activityView.backgroundColor = .init(white: 0.6, alpha: 0.5)
        activityView.insertSubview(subView, at: 0)
        view.addSubview(activityView)
        view.bringSubviewToFront(activityView)
    }
}
