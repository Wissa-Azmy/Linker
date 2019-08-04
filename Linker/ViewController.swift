//
//  ViewController.swift
//  Linker
//
//  Created by Wissa Azmy on 8/3/19.
//  Copyright © 2019 Wissa Michael. All rights reserved.
//

import UIKit

enum ProfileType: String {
    case guest = "Guest" // default
    case host = "Host"
}

class ViewController: UIViewController {
    var currentProfile = ProfileType.guest
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFor(profileType: currentProfile)
    }
    @IBAction func didPressSwitchProfile(_ sender: Any) {
        currentProfile = currentProfile == .guest ? .host : .guest
        configureFor(profileType: currentProfile)
    }
    func configureFor(profileType: ProfileType) {
        title = profileType.rawValue
        ShortcutParser.registerShortcuts(for: profileType)
    }
 
}


