//
//  AlertController.swift
//  Rick and Morty
//
//  Created by Kate on 02.08.2021.
//

import UIKit

struct Alert {
    static func showAlert(on viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
}
