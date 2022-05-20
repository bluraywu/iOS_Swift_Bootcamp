//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Ray WU on 19/05/2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct CalculatorBrain {
    var bmi: Bmi?

    mutating func calculateBMI(h high: Float, w weigh: Float) {
        let bmiValue = weigh / pow(high, 2)
        if bmiValue < 18.5 {
            bmi = Bmi(value: bmiValue, advice: "Eat more pies", color: UIColor.cyan)
        } else if bmiValue < 24.9 {
            bmi = Bmi(value: bmiValue, advice: "Fit as a fiddle!", color: UIColor.green)
        } else {
            bmi = Bmi(value: bmiValue, advice: "Eat less Pies!", color: UIColor.red)
        }
    }

    func getBMIValue() -> String {
        String(format: "%.2f", bmi?.value ?? 0.0)
    }

    func getAdvice() -> String {
        bmi?.advice ?? "No advice"
    }

    func getColor() -> UIColor {
        bmi?.color ?? UIColor.red
    }
}