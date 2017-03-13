//
//  SettingsViewController.swift
//  Tipster
//
//  Created by Huang, Alex on 3/12/17.
//  Copyright © 2017 Huang, Alex. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: ViewController {
    
    @IBOutlet weak var zeroSection: UITextField!
    @IBOutlet weak var firstSection: UITextField!
    @IBOutlet weak var secondSection: UITextField!
    @IBOutlet weak var percentage: UISegmentedControl!
    
    override func viewDidLoad() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadCustomDefaultArray()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.setNewArray()
    }
    
    fileprivate func loadCustomDefaultArray() {
        let selected = SettingsViewController.loadDefaultSelected()
        percentage.selectedSegmentIndex = selected
        
        let customArray = SettingsViewController.loadArrayDefaults()
        
        if customArray.count == 3 {
            zeroSection.text = "\(customArray[0])"
            firstSection.text = "\(customArray[1])"
            secondSection.text = "\(customArray[2])"
            
            for (index, element) in customArray.enumerated() {
                percentage.setTitle("\(element * 100)", forSegmentAt: index)
            }
        }
        self.view.layoutIfNeeded()
    }
    
    @IBAction func setNewArray() {
        guard let zero = Double(zeroSection.text!), let first = Double(firstSection.text!), let second = Double(secondSection.text!) else {
            NSLog("Big error")
            return
        }
        let newArray = [zero, first, second]
        SettingsViewController.setArrayDefaults(array: newArray)
        NSLog("New Array \(newArray)")
        self.loadCustomDefaultArray()
    }
    
    @IBAction func saveDefaultSelected(_ sender: UISegmentedControl) {
        let defaults = UserDefaults.standard
        defaults.set(sender.selectedSegmentIndex, forKey: "Default_Selected_Segment")
        defaults.synchronize()
        NSLog("selected index \(sender.selectedSegmentIndex)")
    }
    
    static func loadDefaultSelected() -> Int {
        let defaults = UserDefaults.standard
        let savedSelectedSegment = defaults.integer(forKey: "Default_Selected_Segment") as Int
        return savedSelectedSegment
    }
    
    static func loadArrayDefaults() -> Array<Double> {
        let defaults = UserDefaults.standard
        guard let savedArray = defaults.object(forKey: "Default_Array") as? Array<Double> else {
            let defaultArray = [0.18, 0.2, 0.25]
            SettingsViewController.setArrayDefaults(array: defaultArray)
            return defaultArray
        }
        return savedArray
    }
    
    static func setArrayDefaults(array: Array<Double>) {
        let defaults = UserDefaults.standard
        defaults.set(array, forKey: "Default_Array")
        defaults.synchronize()
    }
    
    @IBAction func dismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
