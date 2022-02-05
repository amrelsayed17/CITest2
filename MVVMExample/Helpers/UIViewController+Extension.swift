//
//  UIViewController+Extension.swift
//  MVVMExample
//
//  Created by Mac on 1/31/22.
//


import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    func showIndicator(withTitle title: String, and description: String) {
        let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.label.text = title
        indicator.isUserInteractionEnabled = false
        indicator.detailsLabel.text = description
        indicator.show(animated: true)
        self.view.isUserInteractionEnabled = false
    }
    func hideIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
        self.view.isUserInteractionEnabled = true
    }

}
