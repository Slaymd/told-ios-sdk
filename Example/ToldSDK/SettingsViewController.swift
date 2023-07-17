//
//  SettingsViewController.swift
//  ToldSDK_Example
//
//  Created by Darius MARTIN on 24/05/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import Told

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var ui_projectIdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ui_projectIdTextField.delegate = self
        ui_projectIdTextField.returnKeyType = .done
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Told.initSDK(projectId: ui_projectIdTextField.text ?? "")
        textField.resignFirstResponder()
        return true
    }

}
