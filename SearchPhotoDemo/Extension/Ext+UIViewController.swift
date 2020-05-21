//
//  Ext+UIViewController.swift
//  SearchPhotoDemo
//
//  Created by Judy on 2020/5/21.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import UIKit

extension UIViewController{
    func hiddenKeyBoardWhenTapView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        gesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(gesture)
    }
    
    @objc fileprivate func dismissKeyboard(){
        view.endEditing(true)
    }
}
