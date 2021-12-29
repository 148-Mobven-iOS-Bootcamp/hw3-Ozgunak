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
//    private var momento: Double = 0
//    private var firstOperant: Double = 0
//    private var lastOperator: String = ""
    var result: Double {
        get {
            return accumulator
        }
    }
    //MARK: - Complated after watching Stanford CS193P course, added C and CE over lecture

    private var operations = [
        "√" : Operation.UnaryOperator(sqrt),
        "x" : Operation.BinaryOperator({$0 * $1}),
        "÷" : Operation.BinaryOperator({$0 / $1}),
        "+" : Operation.BinaryOperator({$0 + $1}),
        "-" : Operation.BinaryOperator({$0 - $1}),
        "=" : Operation.Equals,
        "C" : Operation.Constant(0),
        "CE" : Operation.CEReset
    ]
    
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperator((Double) -> Double)
        case BinaryOperator((Double, Double) -> Double)
        case Equals
        case CEReset
    }
    private func executePending() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    func performOperation(_ operation: String) {
        //MARK: - Complated after watching Stanford CS193P course
        
        if let calculate = operations[operation] {
            switch calculate {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperator(let function):
                accumulator = function(accumulator)
            case .BinaryOperator(let function):
                executePending()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePending()
            case .CEReset:
                accumulator = 0
                pending = nil
            }
        }

        
        
        //MARK: - Complated homework after Bootcamp course
        /*
        guard let operation = operation else { return }
        
        switch operation {
        case "√":
            accumulator = sqrt(result)
        case "+":
            firstOperant = result
            lastOperator = "+"
        case "÷":
            firstOperant = result
            lastOperator = "÷"
        case "x":
            firstOperant = result
            lastOperator = "x"
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
         */
    }
    
    func setOperand(_ value: Double) {
        accumulator = value
    }
}
