//
//  Ext+UIVC_AlertViewController.swift
//  Extension
//
//  Created by wits on 2019/12/27.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import UIKit

extension UIViewController{
    enum CloseType {
        case dismiss, action1, action2
    }
    
    /// SwifterExt: Stop Activity of Alert
    /// - Parameters:
    ///   - title: Warning title
    ///   - msg: Warning message
    @discardableResult func presentAlert(
            title: String?, subTitle: String? = nil, msg: String?) -> AlertViewController? {
        // init alert
        let alert = AlertViewController.shared
        alert.modalPresentationStyle = .overFullScreen
        alert.modalTransitionStyle = .coverVertical
        
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else{ return nil }
        guard rootVC.presentedViewController == nil else{ return nil }
        // set title and message
        alert.set(title: title, subTitle: subTitle, msg: msg)
        rootVC.present(alert, animated: true)
        return alert
    }
    
    /// SwifterExt: Present Alert
    /// - modalPresentationStyle: .overFullScreen
    /// - modalTransitionStyle: .coverVertical
    /// - Parameters:
    ///   - title: alert title
    ///   - msg: alert content
    ///   - actionTitle: button title
    ///   - action: button action closure
    @discardableResult func presentAlert(
            title: String?, subTitle: String? = nil, msg: String?,
            closeType: CloseType = .action1,
            actionTitle: String?,
            action: AlertActionHandle? = nil)  -> AlertViewController? {
        // init alert
        let alert = AlertViewController.shared
        alert.modalPresentationStyle = .overFullScreen
        alert.modalTransitionStyle = .coverVertical
        
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else{ return nil }
        guard rootVC.presentedViewController == nil else{ return nil }
        // set title and message
        alert.set(title: title, subTitle: subTitle, msg: msg)
        // add action
        let actionHandle: AlertActionHandle = { sender  in
            action?(sender)
        }
        alert.addAction(title: actionTitle, actionHandle)
        switch closeType {
        case .action1:
            alert.closeHandle = actionHandle
        default:
            break
        }
        
        rootVC.present(alert, animated: true)
        return alert
    }
    
    /// SwifterExt: Present Alert
    /// - Parameters:
    ///   - title: alert title
    ///   - msg: alert content
    ///   - actionTitle: top button title
    ///   - action2Title: bottom button title
    ///   - action: top button action closure
    ///   - action2: bottom button action closure
    @discardableResult func presentAlert(
            title: String?, subTitle: String? = nil, msg: String?,
            closeType: CloseType = .action2,
            actionTitle: String?,
            action2Title: String?,
            action: AlertActionHandle? = nil,
            action2: AlertActionHandle? = nil) -> AlertViewController? {
        // init alert
        let alert = AlertViewController.shared
        alert.modalPresentationStyle = .overFullScreen
        alert.modalTransitionStyle = .coverVertical
        
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else{ return nil }
        guard rootVC.presentedViewController == nil else{ return nil }
        // set title and message
        alert.set(title: title, subTitle: subTitle, msg: msg)
        // add action
        let actionHandle: AlertActionHandle = {sender in
            action?(sender)
        }
        alert.addAction(title: actionTitle, actionHandle)
        
        let actionHandle2: AlertActionHandle = {sender  in
            action2?(sender)
        }
        alert.addAction2(title: action2Title, actionHandle2)
        switch closeType {
        case .action1:
            alert.closeHandle = actionHandle
        case .action2:
            alert.closeHandle = actionHandle2
        default:
            break
        }
    
        rootVC.present(alert, animated: true)
        return alert
    }
}
