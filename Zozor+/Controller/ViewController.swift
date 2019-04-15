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
    let calculation = Calculation()
    
    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var clearButton: UIButton!
    
    // MARK: - Actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                textView.text = calculation.addNewNumber(i)
            }
        }
    }
    
    @IBAction func didTapClearButton(_ sender: UIButton) {
        textView.text = calculation.removeLastNumber()
        setClearButtonTitle()
    }
    
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
    
    @IBAction func equal() {
        textView.text = textView.text + calculation.calculateTotal()
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        calculation.alertDelegate = self
    }
    
    func setClearButtonTitle() {
        if calculation.stringNumbers.count > 1 {
            clearButton.setTitle("C", for: .normal)
        } else {
            clearButton.setTitle("AC", for: .normal)
        }
    }
}

extension ViewController: AlertDelegate {
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
