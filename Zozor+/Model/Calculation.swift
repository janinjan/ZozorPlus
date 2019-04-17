//
//  Calculation.swift
//  CountOnMe
//
//  Created by Janin Culhaoglu on 09/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation
/**
 * Creation of a delegate protocol that defines the responsibilities of the delegate
 */
protocol AlertDelegate {
    func presentAlert(title: String, message: String)
}

// enum cases of calculation operators of the calculator
enum Operator {
    case addition, subtraction
    
    var sign: String {
        switch self {
        case .addition:
            return "+"
        case .subtraction:
            return "-"
        }
    }
}

/**
 * Calculation class contains all calculation operations
 */
class Calculation {
    // MARK: - Properties
    var alertDelegate: AlertDelegate? // creation of a delegate property in the delegating class to keep track of the delegate
    var stringNumbers: [String] = [String()]
    private var operators: [Operator] = [.addition]
    private let decimalPoint = "."
    private var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    // call the delegate ViewController to display an alert
                    alertDelegate?.presentAlert(title: "Zéro!", message: "Démarrez un nouveau calcul !")
                } else {
                    alertDelegate?.presentAlert(title: "Zéro!", message: "Entrez une expression correcte !")
                }
                return false
            }
        }
        return true
    }
    
    /**
     * Check if we can add a calcul operator
     */
    private var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                alertDelegate?.presentAlert(title: "Zéro!", message: "Expression incorrecte !")
                return false
            }
        }
        return true
    }
    
    /**
     * Check if we can add a decimal point to a number
     */
    private var canAddDecimalPoint: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.contains(decimalPoint) {
                print("User can not add two decimal points to a number")
                return false
            }
        }
        return true
    }
    
    // MARK: - Methods
    /**
     * Add a number and returns it in a String
     */
    func addNewNumber(_ newNumber: Int) -> String {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        return updateDisplay()
    }
    
    /**
     * Add decimal point to the current number if canAddDecimalPoint returns true
     */
    func addDecimalPoint() -> String {
        if canAddDecimalPoint {
            if let stringNumber = stringNumbers.last {
                var stringNumberMutableInFloat = stringNumber
                stringNumberMutableInFloat += decimalPoint
                stringNumbers[stringNumbers.count-1] = stringNumberMutableInFloat
            }
        }
        return updateDisplay()
    }
    
    /**
     * Add operator whom calculate with
     */
    func calculate(with _operator: Operator) -> String {
        if canAddOperator {
            operators.append(_operator)
            stringNumbers.append("")
        }
        return updateDisplay()
    }
    
    func calculateTotal() -> String {
        if !isExpressionCorrect {
            return ""
        }
        var total: Float = 0.0
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Float(stringNumber) {
                if operators[i] == .addition {
                    total += number
                } else if operators[i] == .subtraction {
                    total -= number
                }
            }
        }
        clear()
        return "=\(total)"
    }
    
    private func updateDisplay() -> String {
        var text = ""
        for (i, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if i > 0 {
                text += operators[i].sign
            }
            // Add number
            text += stringNumber
        }
        return text
    }
    
    /**
     * Clear any stored values and operators
     */
    private func clear() {
        stringNumbers = [String()]
        operators = [.addition]
    }
    
    func removeLastNumber() -> String {
        if stringNumbers.count == 1 {
            clear()
        } else {
            stringNumbers.removeLast() // the current value in the display field is cleared
            operators.removeLast() // the current operator is cleared
        }
        return updateDisplay()
    }
}
