//
//  ViewController.swift
//  Tipster
//
//  Created by Huang, Alex on 3/8/17.
//  Copyright © 2017 Huang, Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billField.becomeFirstResponder()

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadPreferences()
        if billField != nil {
            self.recalculateTip()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    }
    
    fileprivate func loadPreferences() {
        if tipControl != nil {
            let selected = SettingsViewController.loadDefaultSelected()
            tipControl.selectedSegmentIndex = selected
            
            let customArray = SettingsViewController.loadArrayDefaults()
            for (index, element) in customArray.enumerated() {
                tipControl.setTitle("\(element * 100)", forSegmentAt: index)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

    @IBAction func tipControlChanged(_ sender: Any) {
        self.recalculateTip()
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        self.recalculateTip()
    }
    
    fileprivate func recalculateTip() {
        let tipPercentages = SettingsViewController.loadArrayDefaults()
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
}

