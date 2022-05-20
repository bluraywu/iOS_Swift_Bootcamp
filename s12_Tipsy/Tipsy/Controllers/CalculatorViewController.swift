//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!

    var tip = 0.0
    var splitNumber = 2
    var billValue = 0.0
    var total = 0.0
    var totalPerPerson = "0.0"

    @IBAction func tipChange(_ sender: UIButton) {
        billTextField.endEditing(true)

        let buttons = [zeroPctButton, tenPctButton, twentyPctButton]
        buttons.forEach { (button) in
            button?.isSelected = false
        }
        sender.isSelected = true

        let buttonTitle = sender.currentTitle!
        let buttonTitleWithoutPct = String(buttonTitle.dropLast())
        let tipValue = Double(buttonTitleWithoutPct)!
        tip = tipValue / 100
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumber = Int(sender.value)
        splitNumberLabel.text = String(splitNumber)
    }

    @IBAction func calculatePressed(_ sender: UIButton) {
        billValue = Double(billTextField?.text ?? "0.0") ?? 0.0
        
        total = billValue + (billValue * tip)
        totalPerPerson = String(format: "%.2f", total / Double(splitNumber))
        performSegue(withIdentifier: "goToResult", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.total = totalPerPerson
            destinationVC.splitNumber = String(splitNumber)
            destinationVC.tip = String(tip * 100)
        }
    }

}

