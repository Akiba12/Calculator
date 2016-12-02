//
//  ViewController.swift
//  Calculator
//
//  Created by Natalya Kim on 02/12/2016.
//  Copyright © 2016 natalyakim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var displayResultLabel: UILabel!
    var stillTyping = false
    var dotIsPressed = false
    var firstOperand : Double = 0
    var secondOperand : Double = 0
    var operatorSign : String = ""
    
    var currentInput : Double{
        
        get{
            return Double(displayResultLabel.text!)!
        }
        
        set{
            let value = "\(newValue)"
//            let valueArray = value.characters.split(separator: ".") .map(String.init)
            let valueArray = value.components(separatedBy: ".")
            print(valueArray)
            if valueArray[1] == "0" {
                displayResultLabel.text = "\(valueArray[0])"
            }else{
                 displayResultLabel.text = "\(newValue)"
            }
            stillTyping = false
        }
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//       return .lightContent
//    }

    
    @IBAction func numberPressed(_ sender: UIButton) {
        
        let number = sender.currentTitle!
        
        if stillTyping{
            if (displayResultLabel.text?.characters.count)! < 20 {
                displayResultLabel.text = displayResultLabel.text! + number
            }
        }else{
            displayResultLabel.text = number
            stillTyping = true
        }
    }
    
    
    @IBAction func binaryOperatorPressed(_ sender: UIButton) {
        operatorSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPressed = false
    }
    
    func operateWithTwoOperands(operation: (Double,Double) -> Double){
        currentInput = operation(firstOperand,secondOperand)
        stillTyping = false
    }
    
    @IBAction func equalSignPressed(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput
        }
        print("\(firstOperand) \(secondOperand)")
        dotIsPressed = false
        
        switch operatorSign {
        case "+":
            operateWithTwoOperands{$0 + $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        case "×":
            operateWithTwoOperands{$0 * $1}
        case "÷":
            if(secondOperand == 0){
            displayResultLabel.text = "Can't divide by 0, press C"
             print ("Can't divide by 0")
            }else{
            operateWithTwoOperands{$0 / $1}
            }
        default:
            break
        }
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayResultLabel.text = "0"
        stillTyping = false
        dotIsPressed = false
        operatorSign = ""
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func persentageButtonPressed(_ sender: UIButton) {
        if firstOperand == 0{
            currentInput = currentInput/100
        }else{
            secondOperand = firstOperand * currentInput / 100
        }
        stillTyping = false
    }
    
    @IBAction func squareRootButtonPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)

    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPressed {
            displayResultLabel.text = displayResultLabel.text! + "."
            dotIsPressed = true
        }else if !stillTyping && !dotIsPressed{
            displayResultLabel.text = "0."
        }
    }
    
    
    

}

