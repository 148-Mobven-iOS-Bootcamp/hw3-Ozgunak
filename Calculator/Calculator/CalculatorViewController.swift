//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Semih Emre ÜNLÜ on 26.12.2021.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet var digitButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private var userIsTyping = false
    
    private var brain = CalculatorBrain()
    
    var result: Double {
        get {
            return Double(resultLabel.text ?? "0.0") ?? 0.0
        }
        set {
            resultLabel.text = String(newValue)
        }
    }
    
    @IBAction func digitButtonTapped(_ sender: UIButton) {
        //MARK: - CS193p Codes
        if sender.titleLabel?.text == "." {
            let text = String(result) + "."
            result = NSString(string: text).doubleValue
        } else if userIsTyping {
            let digit = String(sender.tag)
            print(sender.tag)
            var text = resultLabel.text!
            text = text + digit
            result = NSString(string: text).doubleValue
            
        } else{
            let digit = String(sender.tag)
            resultLabel.text = digit
            userIsTyping.toggle()
        }
        
        
        //MARK: - Bootcamp codes
        
        /*
         if userIsTyping {
         var resultText = String(Int(result))
         resultText = resultText + String(sender.tag)
         result = NSString(string: resultText).doubleValue
         } else {
         resultLabel.text = String(sender.tag)
         userIsTyping.toggle()
         }
         */
    }
    
    @IBAction func operationButtonTapped(_ sender: UIButton) {
        userIsTyping = false
        brain.setOperand(result)
        brain.performOperation(sender.titleLabel?.text ?? "")
        result = brain.result
    }
}

