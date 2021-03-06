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
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .updatefavoritefromAlbun, object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func update(_ notification: Notification) {
        updateHandle()
    }
    
    func updatefavorite(photo: PhotoCellViewModel) {
        favoriteAlbum.update(photo: photo)
        updateHandle()
        NotificationCenter.default.post(name: .updatefavoritefromFavorite, object: nil)
    }
}
