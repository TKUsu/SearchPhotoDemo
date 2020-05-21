//
//  ViewController.swift
//  SearchPhotoDemo
//
//  Created by Judy on 2020/5/21.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import UIKit

class SearchViewController: SuperViewController {
    static var storyBoardID: String = "SearchViewController"
    
    @IBOutlet weak var Fid_search: UITextField!
    @IBOutlet weak var Fid_prePage: UITextField!
    @IBOutlet weak var Btn_search: UIButton!
    
    private var enableSearch: Bool{
        set{
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.Btn_search.tintColor = newValue ? .cyan : .white
                self?.Btn_search.backgroundColor = newValue ? .gray : .lightGray
            }
            Btn_search.isEnabled = newValue
        }
        get{
            return Btn_search.isEnabled
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupStyle()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @IBAction func searchAction(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withClass: AlbumViewController.self) else{ return }
        vc.searchText = self.Fid_search.text!
        vc.perPage = self.Fid_prePage.text!
        navigationController?.pushViewController(vc)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        DispatchQueue.main.async {
            self.enableSearch = (self.Fid_search.text != "") && (self.Fid_prePage.text != "")
        }
    }
    
    // MARK: - Private
    private func setup(){
        enableSearch = false
        Fid_search.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        Fid_prePage.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    private func setupStyle(){
        title = "Search"
        Fid_prePage.keyboardType = .numberPad
        Btn_search.layer.masksToBounds = true
        Btn_search.layer.cornerRadius = Btn_search.frame.height / 2
    }
}
