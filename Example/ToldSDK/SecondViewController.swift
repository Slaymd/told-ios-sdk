//
//  SecondViewController.swift
//  ToldSDK_Example
//
//  Created by Darius MARTIN on 17/06/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCloseClick(_ sender: Any) {
        dismiss(animated: true)
    }
}
