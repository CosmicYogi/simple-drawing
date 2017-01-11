//
//  SettingsViewController.swift
//  Simple Drawing
//
//  Created by mitesh soni on 11/01/17.
//  Copyright © 2017 Mitesh Soni. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController{

    weak var drawingVC : DrawingViewController? = nil;
    
    var brushSize : Float?
    var inRainbowMode: Bool?
    @IBOutlet weak var rainbowSwitch: UISwitch!
    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false;
        if brushSize != nil{
            slider.value = brushSize!;
        }
        if inRainbowMode != nil{
            rainbowSwitch.setOn(inRainbowMode!, animated: false);
        }
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
    
    @IBAction func switchTapped(_ sender: UISwitch) {
        print(sender.state);
        if sender.isOn{
            self.drawingVC?.inRainbowMode = true;
        } else{
            self.drawingVC?.inRainbowMode = false;
            drawingVC?.red = 0;
            drawingVC?.green = 0;
            drawingVC?.blue = 0;
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.drawingVC?.brushSize = CGFloat(sender.value);
    }
    
}
