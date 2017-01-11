//
//  DrawingViewController.swift
//  Simple Drawing
//
//  Created by mitesh soni on 11/01/17.
//  Copyright © 2017 Mitesh Soni. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    
    var red : CGFloat = 0.0;
    var green : CGFloat = 0.0;
    var blue : CGFloat = 0.0;
    var moveCount = 0;
    var lastPoint = CGPoint.zero;
    
    var brushSize : CGFloat = 5.0;
    var inRainbowMode = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(DrawingViewController.appBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive , object: nil);
    }
    
    func appBecomeActive(){
        // for solving the issue related to the visibility of stack view carrying buttons.
        buttonsStackView.isHidden = false;
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true;
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches Begin");
        buttonsStackView.isHidden = true;
        if let touch = touches.first{
            let point = touch.location(in: imageView);
            //print(point);
            self.lastPoint = point;
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let point = touch.location(in: imageView);
            //print(point);
            drawBetweenPoints(firstPoint: self.lastPoint, secondPoint: point)
            self.lastPoint = point;
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches Ended");
        buttonsStackView.isHidden = false;
        if let touch = touches.first{
            let point = touch.location(in: imageView);
            drawBetweenPoints(firstPoint: self.lastPoint, secondPoint: point);
        }
    }
    
    func erase(){
        self.imageView.image = nil;
    }
    
    func drawBetweenPoints(firstPoint: CGPoint, secondPoint: CGPoint){
        UIGraphicsBeginImageContext(self.imageView.frame.size);
        let context = UIGraphicsGetCurrentContext();
        
        self.imageView.image?.draw(in: CGRect(x: 0, y: 0, width : self.imageView.frame.size.width, height: self.imageView.frame.height));
        //CGContextMoveToPoint(context, self.lastPoint.x, self.lastPoint.y);
        context?.move(to: firstPoint);
        context?.addLine(to: secondPoint);
        if inRainbowMode{
            randomTapped(UIButton());
        }
        
        context?.setStrokeColor(red: self.red, green: self.green, blue: self.blue, alpha: 1);
        context?.setLineWidth(brushSize);
        context?.setLineCap(.round);

        context?.strokePath();
        
        
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "drawingToSettingsSegue" {
            let settingsVC = segue.destination as! SettingsViewController;
            settingsVC.drawingVC = self;
            settingsVC.brushSize = Float(self.brushSize);
            settingsVC.inRainbowMode = self.inRainbowMode;
        }
            
    }
    
    @IBAction func blueTapped(_ sender: UIButton) {
        self.red = 56/255;
        self.green = 109/255;
        self.blue = 229/255;
    }
    @IBAction func greenTapped(_ sender: UIButton) {
        //54 233 119
        self.red = 54/255;
        self.green = 233/255;
        self.blue = 119/255;
    }
    @IBAction func redTapped(_ sender: UIButton) {
        // 227 58 62
        self.red = 227/255;
        self.green = 58/255;
        self.blue = 62/255;
    }
    @IBAction func yellowTapped(_ sender: UIButton) {
        // 248 213 55
        self.red = 248/255;
        self.green = 213/255;
        self.blue = 55/255;
    }
    @IBAction func randomTapped(_ sender: UIButton) {
        print("random color selected");
        self.red = CGFloat(arc4random_uniform(256)) / 255;
        self.green = CGFloat(arc4random_uniform(256)) / 255;
        self.blue = CGFloat(arc4random_uniform(256)) / 255;
        print(self.red, self.green, self.blue);
    }
}

