//
//  AlertMessages.swift
//
//  Created by Amr Elsayed on 1/15/18.
//  Copyright © 2018 Amr Elsayed. All rights reserved.

import UIKit
import SwiftMessages

class AlertMessages: NSObject {


    static func showMessage(title:String , body:String , theme:Theme)
    {
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(theme)
        view.configureDropShadow()
        
        view.configureContent(title: title, body: body )
        view.button?.isHidden=false
        view.button?.setTitle("Done", for: .normal)
        view.buttonTapHandler = { _ in SwiftMessages.hide() }
        var config = SwiftMessages.defaultConfig
        config.duration =  .seconds(seconds: 3)
        config.presentationStyle = .bottom
        SwiftMessages.show(config: config, view: view)

    }

}
