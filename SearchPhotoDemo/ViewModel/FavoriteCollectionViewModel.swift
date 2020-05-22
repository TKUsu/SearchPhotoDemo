//
//  FavoriteCollectionViewModel.swift
//  SearchPhotoDemo
//
//  Created by Judy on 2020/5/22.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import Foundation

class FavoriteCollectionViewModel {
    var updateHandle: (()->())!
    
    init() { }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .updatefavorite, object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func update(_ notification: Notification) {
        updateHandle()
    }
}
