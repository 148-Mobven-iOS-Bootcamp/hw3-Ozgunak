//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Semih Emre ÜNLÜ on 26.12.2021.
//

import Foundation

class CalculatorBrain {
    //istenen işlemler + - * / bonus C CE =
    //standford university ios 9 > youtube video 1 ya da 2
    private var accumulator: Double = 0
    private var momento: Double = 0
    private var firstOperant: Double = 0
    private var lastOperator: String = ""
    var result: Double {
        get {
            return accumulator
        }
    }

    func performOperation(_ operation: String?) {
        guard let operation = operation else { return }

        switch operation {
        case "√":
            accumulator = sqrt(result)
        case "+":
            firstOperant = result
            lastOperator = "+"
        case "/":
            firstOperant = result
            lastOperator = "/"
        case "*":
            firstOperant = result
            lastOperator = "*"
        case "-":
            firstOperant = result
            lastOperator = "-"
        case "=":
            if lastOperator == "+" {
                accumulator = firstOperant + result
            }else if lastOperator == "-" {
                accumulator = firstOperant - result
            }else if lastOperator == "x" {
                accumulator = firstOperant * result
            }else if lastOperator == "/" {
                accumulator = firstOperant / result
            }
            
        case "C":
            accumulator = 0
        case "CE":
            accumulator = 0
            firstOperant = 0
            lastOperator = ""
        default:
            break
        }
    }

    func setOperand(_ value: Double) {
        accumulator = value
    }
}
