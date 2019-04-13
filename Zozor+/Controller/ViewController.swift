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
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        calculation.alertDelegate = self
    }
    
    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    // MARK: - Actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                textView.text = calculation.addNewNumber(i)
            }
        }
    }
    
    @IBAction func plus() {
        textView.text = calculation.calculate(with: .addition)
    }
    
    @IBAction func minus() {
        textView.text = calculation.calculate(with: .subtraction)
    }
    
    @IBAction func equal() {
        textView.text = textView.text + calculation.calculateTotal()
    }
}

extension ViewController: AlertDelegate {
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
