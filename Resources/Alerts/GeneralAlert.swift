//
//  GeneralAlert.swift
//  Git
//
//  Created by Kollokvium on 12/11/18.
//  Copyright © 2018 Anton Klymenko. All rights reserved.
//

import Foundation
import UIKit

struct GeneralAlert {
    // Single Message & Acceptance
    static func showMessage(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
}
