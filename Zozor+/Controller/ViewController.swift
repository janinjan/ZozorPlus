//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    let calculation = Calculation() // Created instance of Calculation class

    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var clearButton: UIButton!

    // MARK: - Actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() where sender == numberButton {
                textView.text = calculation.addNewNumber(i)
            }
        }

    /**
     * Clears last stored value and remove it from the display field
     */
    @IBAction func didTapClearButton(_ sender: UIButton) {
        textView.text = calculation.removeLastNumber()
        setClearButtonTitle()
    }

    /**
     * Adds decimal point to a number
     */
    @IBAction func didTapDecimalPoint(_ sender: UIButton) {
        textView.text = calculation.addDecimalPoint()
    }

    @IBAction func plus() {
        textView.text = calculation.calculate(with: .addition)
        setClearButtonTitle()
    }

    @IBAction func minus() {
        textView.text = calculation.calculate(with: .subtraction)
        setClearButtonTitle()
    }

    /**
     * Gets result of calculation by pressing equal and displays it
     */
    @IBAction func equal() {
        textView.text += "=\(calculation.calculateTotal())"
    }

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        calculation.alertDelegate = self // add a delegate to the created instance and assign it to ViewController
    }

    /**
     * Clear button can dislay "C" or "AC"
     */
    private func setClearButtonTitle() {
        if calculation.stringNumbers.count > 1 {
            // title change to "C" when at least a number + an operator are pressed. ex: "2+"
            clearButton.setTitle("C", for: .normal)
        } else {
            // title change to "AC" when clear button is pressed and only one number is displayed. ex: "2"
            clearButton.setTitle("AC", for: .normal)
        }
    }
}

/**
 * extension of view controller that adopts the protocol in order to conform to the layout defined in AlertDelegate
 */
extension ViewController: AlertDelegate {
    /**
     * Displays an alert with a custom message
     */
    func presentAlert(title: String, message: String) { // implement the delegate function
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
