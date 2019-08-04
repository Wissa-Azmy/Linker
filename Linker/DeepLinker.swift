//
//  DeepLinker.swift
//  Linker
//
//  Created by Wissa Azmy on 8/4/19.
//  Copyright © 2019 Wissa Michael. All rights reserved.
//

import Foundation
import UIKit

enum DeeplinkType {
    enum Messages {
        case root
        case details(id: String)
    }
    case messages(Messages)
    case activity
    case newListing
    case request(id: String)
}

class DeepLinkManager {
    private var deeplinkType: DeeplinkType?
    // check existing deepling and perform action
    
    func checkDeepLink() {
        guard let deeplinkType = deeplinkType else {
            return
        }
        
        proceedToDeeplink(deeplinkType)
        // reset deeplink after handling
        self.deeplinkType = nil // (1)
    }
    
    @discardableResult
    func handleShortcut(item: UIApplicationShortcutItem) -> Bool {
        deeplinkType = ShortcutParser.shared.handleShortcut(item) // we will parse the item here
        return deeplinkType != nil
    }
    
    func proceedToDeeplink(_ type: DeeplinkType) {
        switch type {
        case .activity:
            displayAlert(title: "Activity")
        case .messages(.root):
            displayAlert(title: "Messages Root")
        case .messages(.details(id: let id)):
            displayAlert(title: "Messages Details \(id)")
        case .newListing:
            displayAlert(title: "New Listing")
        case .request(id: let id):
            displayAlert(title: "Request Details \(id)")
        }
    }
    
    let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
    
    
    private var alertController = UIAlertController()
    private func displayAlert(title: String) {
        alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okButton)
        let vc = keyWindow?.rootViewController
        
        if vc?.presentedViewController != nil {
            alertController.dismiss(animated: false, completion: {
                vc?.present(self.alertController, animated: true, completion: nil)
            })
        } else {
            vc?.present(alertController, animated: true, completion: nil)
        }
    }
}
