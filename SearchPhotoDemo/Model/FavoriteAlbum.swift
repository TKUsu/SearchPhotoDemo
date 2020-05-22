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
    
    mutating func update(photo: PhotoCellViewModel) {
        if photo.isfavorite && !_album.contains(where: {$0.id == photo.id}) {
            _album.append(photo)
        }else if !photo.isfavorite {
            for i in 0..<_album.count {
                if _album[i].id == photo.id{
                    _album.remove(at: i)
                    return
                }
            }
        }
    }
}
