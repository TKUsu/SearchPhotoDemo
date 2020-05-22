//
//  AlbumCollectionViewCell.swift
//  SearchPhotoDemo
//
//  Created by Judy on 2020/5/21.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var Lbl_title: UILabel!
    @IBOutlet weak var Btn_favorite: UIButton!
    
    var photo: PhotoCellViewModel?
    var onFavorite: ((_ photo: PhotoCellViewModel)->())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clear()
    }
    
    func setup(with photo: PhotoCellViewModel) {
        clear()
        self.photo = photo
        
        self.Lbl_title.text = photo.title
        DispatchQueue.init(label: "downloadURL").async {
            photo.download{[weak self] image in
                DispatchQueue.main.async {
                    self?.imgV.image = image
                }
            }
        }
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        guard photo != nil else{ return }
        photo!.isfavorite = !photo!.isfavorite
        setBtnImage()
        onFavorite(photo!)
    }
    
    fileprivate func clear() {
        imgV.image = nil
        Lbl_title.text = ""
        photo = nil
        Btn_favorite.setImageForAllStates(UIImage.unfavorite!)
    }
    
    fileprivate func setBtnImage() {
        if let image = photo!.isfavorite ? UIImage.favorite : UIImage.unfavorite{
            self.Btn_favorite.setImageForAllStates(image)
        }
    }
}
