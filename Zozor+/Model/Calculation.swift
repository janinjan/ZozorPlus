//
//  Calculation.swift
//  CountOnMe
//
//  Created by Janin Culhaoglu on 09/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation
protocol AlertDelegate {
    func presentAlert(title: String, message: String)
}

enum Operator {
    case addition
    case subtraction
    
    var sign: String {
        switch self {
        case .addition:
            return "+"
        case .subtraction:
            return "-"
        }
    }
}

class Calculation {
    // MARK: - Properties
    var alertDelegate: AlertDelegate?
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    alertDelegate?.presentAlert(title: "Zéro!", message: "Démarrez un nouveau calcul !")
                } else {
                    alertDelegate?.presentAlert(title: "Zéro!", message: "Entrez une expression correcte !")
                }
                return false
            }
        }
        return true
    }
    
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                alertDelegate?.presentAlert(title: "Zéro!", message: "Expression incorrecte !")
                return false
            }
        }
        return true
    }
    
    // MARK: - Methods
    func addNewNumber(_ newNumber: Int) -> String {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        return updateDisplay()
    }
    
    func calculate(with _operator: Operator) -> String {
        if canAddOperator {
            operators.append(_operator.sign)
            stringNumbers.append("")
        }
        return updateDisplay()
    }
    
    func calculateTotal() -> String {
        if !isExpressionCorrect {
            return ""
        }
        var total = 0
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
                if operators[i] == "+" {
                    total += number
                } else if operators[i] == "-" {
                    total -= number
                }
            }
        }
        clear()
        return "=\(total)"
    }
    
    func updateDisplay() -> String {
        var text = ""
        for (i, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if i > 0 {
                text += operators[i]
            }
            // Add number
            text += stringNumber
        }
        return text
    }
    
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
    }
    
    func removeLastNumber() -> String {
        if stringNumbers.count == 1 {
            clear()
        } else {
            stringNumbers.removeLast()
            operators.removeLast()
        }
        return updateDisplay()
    }
}
