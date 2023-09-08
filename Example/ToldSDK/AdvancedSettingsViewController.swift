//
//  AdvancedSettingsViewController.swift
//  ToldSDK_Example
//
//  Created by Darius MARTIN on 05/05/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import Told

class AdvancedSettingsViewController: UIViewController, UITextFieldDelegate {
        
    @IBOutlet weak var ui_hiddenFields: UITextField!
    @IBOutlet weak var ui_projectId: UITextField!
    @IBOutlet weak var ui_surveyId: UITextField!
    @IBOutlet weak var ui_apiRoot: UITextField!
    @IBOutlet weak var ui_widgetRoot: UITextField!
    @IBOutlet weak var ui_eventName: UITextField!
    @IBOutlet weak var ui_eventProperties: UITextField!
    
    var defaultProjectId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ui_hiddenFields.delegate = self
        ui_projectId.delegate = self
        ui_surveyId.delegate = self
        ui_apiRoot.delegate = self
        ui_widgetRoot.delegate = self
        ui_eventName.delegate = self
        ui_eventProperties.delegate = self
        
        if let savedHiddenFields = UserDefaults.standard.string(forKey: "hiddenFields") {
            ui_hiddenFields.text = savedHiddenFields
        }
        if let savedDefaultProjectId = UserDefaults.standard.string(forKey: "defaultProjectId") {
            ui_projectId.text = savedDefaultProjectId
            defaultProjectId = savedDefaultProjectId
        }
        if let savedApiRoot = UserDefaults.standard.string(forKey: "apiRoot") {
            ui_apiRoot.text = savedApiRoot
            if let savedWidgetRoot = UserDefaults.standard.string(forKey: "widgetRoot") {
                ui_widgetRoot.text = savedWidgetRoot
                Told.setServerAPI(apiRootUrl: savedApiRoot, widgetRootUrl: savedWidgetRoot)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseHiddenFieldsString(_ text: String) -> [String: String] {
        let keyValuePairs = text.components(separatedBy: ";")
        
        let dictionary = keyValuePairs.reduce(into: [String: String]()) { result, pair in
            let components = pair.components(separatedBy: "=")
            if components.count == 2 {
                let key = components[0]
                let value = components[1]
                result[key] = value
            }
        }
        
        return dictionary
    }

    @IBAction func onApplyHiddenFieldsClick(_ sender: Any) {
        let hiddenFields = parseHiddenFieldsString(ui_hiddenFields.text ?? "")
        print("Hidden Fields", hiddenFields)
        UserDefaults.standard.set(ui_hiddenFields.text ?? "", forKey: "hiddenFields")
        Told.addHiddenFields(hiddenFields: hiddenFields, setData: true)
    }
    
    @IBAction func onStartSurveyClick(_ sender: Any) {
        let projectId = ui_projectId.text ?? ""
        let surveyId = ui_surveyId.text ?? ""
        
        if (projectId.isEmpty || surveyId.isEmpty) { return }
        Told.start(id: surveyId, projectId: projectId)
    }
    
    @IBAction func onApplyServerURLsClick(_ sender: Any) {
        let apiRoot = ui_apiRoot.text ?? ""
        let widgetRoot = ui_widgetRoot.text ?? ""
        if (apiRoot.isEmpty || widgetRoot.isEmpty) { return }
        UserDefaults.standard.set(apiRoot, forKey: "apiRoot")
        UserDefaults.standard.set(widgetRoot, forKey: "widgetRoot")
        Told.setServerAPI(apiRootUrl: apiRoot, widgetRootUrl: widgetRoot)
    }
    
    @IBAction func onSendCustomEventClick(_ sender: Any) {
        let eventName = ui_eventName.text ?? ""
        let eventProperties = parseHiddenFieldsString(ui_eventProperties.text ?? "")
        
        Told.sendCustomEvent(eventName: eventName, eventProperties: eventProperties)
    }
    
    // MARK: Delegate functions
    
    func textFieldShouldReturn(_ field: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
