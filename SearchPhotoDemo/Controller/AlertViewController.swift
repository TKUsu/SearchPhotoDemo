//
//  AlertViewController.swift
//  ClockIn
//
//  Created by SuJustin on 2019/12/18.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import UIKit

public typealias AlertActionHandle = ((_ sender: UIButton)->())
class AlertViewController: UIViewController {
    static var nibName: String = "AlertViewController"
    static var shared: AlertViewController{
        return AlertViewController(nibName: AlertViewController.nibName, bundle: nil)
    }
    
    var viewRadius: CGFloat{
        set{
            alertView.layer.cornerRadius = newValue
        }
        get{
            return alertView.layer.cornerRadius
        }
    }
    
    var closeHandle: AlertActionHandle? = nil
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var LBl_title: UILabel!
    @IBOutlet weak var Lbl_subTitle: UILabel!
    @IBOutlet weak var Lbl_message: UILabel!

    @IBOutlet weak var Btn_action: UIButton!
    @IBOutlet weak var Btn_action2: UIButton!
    
    private var titleText: String?
    private var text: String?
    private var subTitle: String?
    private var action: (hidden: Bool, title: String?, handle: AlertActionHandle?) = (true, nil, nil)
    private var action2: (hidden: Bool, title: String?, handle: AlertActionHandle?) = (true, nil, nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        resetView()
    }
    
    @IBAction func action1(_ sender: UIButton) {
        closeAction{ [weak self] in
            self?.action.handle?(sender)
        }
    }
    @IBAction func action2(_ sender: UIButton) {
        closeAction{ [weak self] in
            self?.action2.handle?(sender)
        }
    }
}
// MARK: Private
extension AlertViewController{
    fileprivate func resetView() {
        action.hidden = true
        action2.hidden = true
        
        LBl_title.text = ""
        LBl_title.isHidden = true
        Lbl_subTitle.text = ""
        Lbl_subTitle.isHidden = true
        Lbl_message.text = ""
        Lbl_message.isHidden = true
    }
    
    fileprivate func setupView() {
        bgView.backgroundColor = .floatBG
        
        alertView.layer.masksToBounds = true
        alertView.layer.cornerRadius = 10
        
        // FBL
        if #available(iOS 13.0, *) {
            LBl_title.textColor = .label
            Lbl_subTitle.textColor = .label
            Lbl_message.textColor = .label
            alertView.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
        }
        Btn_action.tintColor = .white
        Btn_action.backgroundColor = .green
        Btn_action.layer.masksToBounds = true
        Btn_action.layer.cornerRadius = Btn_action.bounds.height / 2
        
        Btn_action2.tintColor = .white
        Btn_action2.backgroundColor = .red
        Btn_action2.layer.masksToBounds = true
        Btn_action2.layer.cornerRadius = Btn_action.bounds.height / 2
    }
    fileprivate func setup(){
        setupView()
        
        Btn_action.isHidden = action.hidden
        Btn_action.setTitle(action.title, for: .normal)
        Btn_action2.isHidden = action2.hidden
        Btn_action2.setTitle(action2.title, for: .normal)
        
        LBl_title.text = titleText
        LBl_title.isHidden = (titleText == nil)
        Lbl_subTitle.text = subTitle
        Lbl_subTitle.isHidden = (subTitle == nil)
        Lbl_message.text = text
        Lbl_message.isHidden = (text == nil)
        Lbl_message.sizeToFit()
    }
    /// Close Alert
    fileprivate func closeAction(complete: @escaping (()->()) ){
        dismiss(animated: true) {
          // at parent dismiss
            complete()
        }
    }
}
// MARK: Public
extension AlertViewController{
    func set(title: String?, subTitle: String?, msg: String?) {
        self.titleText = title
        self.subTitle = subTitle
        self.text = msg
    }
    
    func addAction(title: String?, _ actionHandle: AlertActionHandle? = nil ) {
        action.hidden = (title == nil)
        action.title = title
        action.handle = actionHandle
    }
    func addAction2(title: String?, _ actionHandle: AlertActionHandle? = nil ) {
        action2.hidden = (title == nil)
        action2.title = title
        action2.handle = actionHandle
    }
}
