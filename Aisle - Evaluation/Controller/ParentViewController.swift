//
//  ParentViewController.swift
//  Aisle - Evaluation
//
//  Created by Abhishek Yadav on 22/08/23.
//

import UIKit

class ParentViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add a tap gesture recognizer to the view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true) // This will dismiss the keyboard
    }

}
