//
// Created by Ray WU on 10/06/2022.
// Copyright (c) 2022 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    private var number: Double?
    private var intermediateCalculation: (n1: Double, calMethod: String)?

    mutating func setNumber(_ number: Double) {
        self.number = number
    }

    mutating func calculate(symbol: String) -> Double? {
        if let n = number {
            switch symbol {
            case "AC": return Double.zero
            case "+/-": return n * -1
            case "%": return n * 0.01
            case "=":
                return performTwoNumCalculation(n2: n)
            default:
                intermediateCalculation = (n, symbol)
            }
        }
        return nil
    }

    private func performTwoNumCalculation(n2: Double) -> Double? {
        if let n1 = intermediateCalculation?.n1,
           let operation = intermediateCalculation?.calMethod {
            switch operation {
            case "+": return n1 + n2
            case "-": return n1 - n2
            case "*": return n1 * n2
            case "/": return n1 / n2
            default: fatalError("The operation passed in does not match any of the cases")
            }
        }
        return nil
    }
}
