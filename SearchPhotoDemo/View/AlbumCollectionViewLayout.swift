//
//  AlbumCollectionViewLayout.swift
//  SearchPhotoDemo
//
//  Created by Judy on 2020/5/21.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import UIKit

class AlbumCollectionViewLayout: UICollectionViewFlowLayout {
    
    init(itemSize: CGSize) {
        super.init()
        self.itemSize = itemSize
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
