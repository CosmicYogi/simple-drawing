//
//  ViewController.swift
//  Simple Drawing
//
//  Created by mitesh soni on 11/01/17.
//  Copyright © 2017 Mitesh Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true;
    }

}

