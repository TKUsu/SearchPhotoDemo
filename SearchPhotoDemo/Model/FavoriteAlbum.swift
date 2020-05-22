//
//  FavoriteAlbum.swift
//  SearchPhotoDemo
//
//  Created by Judy on 2020/5/22.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import Foundation

var favoriteAlbum = FavoriteAlbum.shared
struct FavoriteAlbum {
    static let shared: FavoriteAlbum = FavoriteAlbum()
    
    var album: AlBum{
        return _album
    }
    private var _album: AlBum = []
    private let manager = CoreDataManager.shared
    
    init() {
        match()
    }
    
    mutating func match() {
        let photos = manager.match()
        _album = photos.map({ return PhotoCellViewModel(id: $0.id ?? "", title: $0.title ?? "", imageURL: $0.imageURL ?? "", isfavorite: true)} )
    }
    
    mutating func update(photo: PhotoCellViewModel) {
        if photo.isfavorite && !_album.contains(where: {$0.id == photo.id}) {
            save(photo: photo)
        }else if !photo.isfavorite {
            delete(photo: photo)
        }
    }
    
    func sync(with origin: AlBum, complete: (_ newAlbum: AlBum)->()) {
        var newAlbum: AlBum = []
        origin.forEach({ photo in
            if _album.contains(where: {$0.id == photo.id}) {
                var newPhoto = photo
                newPhoto.isfavorite = true
                newAlbum.append(newPhoto)
            }else{
                var newPhoto = photo
                newPhoto.isfavorite = false
                newAlbum.append(newPhoto)
            }
        })
        complete(newAlbum)
    }
    
    fileprivate mutating func save(photo: PhotoCellViewModel) {
        // Client save
        _album.append(photo)
        // Database save
        manager.createPhoto(id: photo.id, title: photo.title, imageURL: photo.imageURL)
    }
    
    fileprivate mutating func delete(photo: PhotoCellViewModel) {
        // Client
        for i in 0..<_album.count {
            if _album[i].id == photo.id{
                _album.remove(at: i)
                break
            }
        }
        // Database delete
        manager.delete(with: photo)
    }
}
