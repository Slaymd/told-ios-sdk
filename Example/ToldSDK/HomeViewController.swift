//
//  HomeViewController.swift
//  ToldSDK
//
//  Created by Darius on 04/09/2023.
//  Copyright (c) 2023 Darius. All rights reserved.
//

import UIKit
import ToldSDK

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("COUCOU")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTextChanged(_ sender: Any, forEvent event: UIEvent) {
        
        print(event)
    }
}

