//
//  SettingsViewController.swift
//  Simple Drawing
//
//  Created by mitesh soni on 11/01/17.
//  Copyright © 2017 Mitesh Soni. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    weak var drawingVC : DrawingViewController? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false;
    }

    @IBAction func eraseTapped(_ sender: UIBarButtonItem) {
        self.drawingVC?.erase();
        self.navigationController?.popToRootViewController(animated: true);
    }
    @IBAction func shareArtTapped(_ sender: UIButton) {
        if let drawing = self.drawingVC?.imageView.image{
            let activityVC = UIActivityViewController(activityItems: [drawing], applicationActivities: nil);
            self.present(activityVC, animated: true, completion: nil);
        }
    }
    
}
