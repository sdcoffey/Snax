//
//  ViewController.swift
//  SnaxExample
//
//  Created by Coffey, Steven on 9/18/15.
//  Copyright © 2015 Coffey, Steven. All rights reserved.
//

import UIKit
import Snax

class ViewController: UIViewController {

    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var snaxTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showSnaxPressed(sender: AnyObject) {
        let type: SnaxType?
        switch segmentControl.selectedSegmentIndex {
        case 0:
            type = .Full
        case 1:
            type = .Beveled
        case 2:
            type = .Partial
        default:
            type = nil
        }
        
        var text = snaxTextField.text
        if text == nil || text == "" {
            text = "Hello, I am the Snax!"
        }
        
        let mix = SnaxMix(message: text!).setDuration(NSTimeInterval(durationSlider.value))
        if let sType = type {
            mix.setType(sType)
        }
        Snax.show(mix)
    }
    
    @IBAction func sliderValueChanged(sender: AnyObject) {
        if let slider = sender as? UISlider {
            durationLabel.text = String(format: "%.1f", arguments: [slider.value])
        }
    }
    
    @IBAction func keyboardTriggered(sender: AnyObject) {
        snaxTextField.resignFirstResponder()
    }
}

