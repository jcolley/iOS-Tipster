//
//  ViewController.swift
//  iOS-Tipster
//
//  Created by John Colley on 7/11/17.
//  Copyright © 2017 John Colley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputPrice: UITextField!
    @IBOutlet weak var highPercent: UILabel!
    @IBOutlet weak var highTip: UILabel!
    @IBOutlet weak var highTotal: UILabel!
    @IBOutlet weak var midPercent: UILabel!
    @IBOutlet weak var midTip: UILabel!
    @IBOutlet weak var midTotal: UILabel!
    @IBOutlet weak var lowPercent: UILabel!
    @IBOutlet weak var lowTip: UILabel!
    @IBOutlet weak var lowTotal: UILabel!
    @IBOutlet weak var groupSize: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func calcButtonPressed(_ sender: UIButton) {
        var char = String(sender.tag)
        let charset = CharacterSet(charactersIn:".")
        if inputPrice.text?.rangeOfCharacter(from: charset) == nil {
            if char == "10" {
                if inputPrice.text == "0" {
                    char = "0."
                } else {
                    char = "."
                }
            }
        } else {
            if char == "10" {
                char = ""
            }
        }
        if inputPrice.text == "0" {
            inputPrice.text = ""
        }
        if char == "11" {
            inputPrice.text = ""
            char = "0"
        }
        inputPrice.text = inputPrice.text! + char
        
        calc()
    }

    @IBAction func inputPriceChanged(_ sender: UITextField) {
        calc()
    }
    
    @IBAction func tipPercentSlider(_ sender: UISlider) {
        let step: Float = 1.0
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        
        highPercent.text = String(Int(round(20.0 + roundedValue))) + "%"
        midPercent.text = String(Int(15.0 + roundedValue)) + "%"
        lowPercent.text = String(Int(10.0 + roundedValue)) + "%"
        
        calc()
    }
    
    @IBAction func groupSizeSlider(_ sender: UISlider) {
        let step: Float = 1
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        
        groupSize.text = String(Int(sender.value))
        
        calc()
    }
    
    func calc(){
        updateTips()
        updateTotals()
    }
    
    func updateTips(){
        let price = Float(inputPrice.text!)
        let hPerc = Float((highPercent.text?.replacingOccurrences(of: "%", with: ""))!)
        let mPerc = Float((midPercent.text?.replacingOccurrences(of: "%", with: ""))!)
        let lPerc = Float((lowPercent.text?.replacingOccurrences(of: "%", with: ""))!)
        let gSize = Float(groupSize.text!)
        
        
        highTip.text = String(format: "%.2f", (price! * (hPerc! / 100)) / gSize!)
        midTip.text = String(format: "%.2f", (price! * (mPerc! / 100)) / gSize!)
        lowTip.text = String(format: "%.2f", (price! * (lPerc! / 100)) / gSize!)
    }
    
    func updateTotals(){
        let gSize = Float(groupSize.text!)
        let price = Float(inputPrice.text!)! / gSize!
        let hTip = Float(highTip.text!)
        let mTip = Float(midTip.text!)
        let lTip = Float(lowTip.text!)
        
        highTotal.text = String(format: "%.2f", price + hTip!)
        midTotal.text = String(format: "%.2f", price + mTip!)
        lowTotal.text = String(format: "%.2f", price + lTip!)
    }
    
    func getInputPrice() -> Float32 {
        let val = Float32(inputPrice.text!)
        return val!
    }
}

