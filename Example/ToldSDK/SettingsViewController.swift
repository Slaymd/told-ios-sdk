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
    @IBOutlet weak var ui_startExperienceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui_projectIdTextField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        if let savedDefaultProjectId = UserDefaults.standard.string(forKey: "defaultProjectId") {
            ui_projectIdTextField.text = savedDefaultProjectId
        }
        
        if let savedApiRoot = UserDefaults.standard.string(forKey: "apiRoot") {
            if let savedWidgetRoot = UserDefaults.standard.string(forKey: "widgetRoot") {
                Told.setServerAPI(apiRootUrl: savedApiRoot, widgetRootUrl: savedWidgetRoot)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onInitClick(_ sender: Any) {
        
        UserDefaults.standard.set(ui_projectIdTextField.text ?? "", forKey: "defaultProjectId")
        Told.initSDK(projectId: ui_projectIdTextField.text ?? "", params: [.debug])
        let alertController = UIAlertController(title: "Succesfully initialized '\(ui_projectIdTextField.text ?? "")'", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { (action) in
        })
        self.present(alertController, animated: true)
    }
    
    // MARK: Delegate functions
    
    func textFieldShouldReturn(_ field: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

}
