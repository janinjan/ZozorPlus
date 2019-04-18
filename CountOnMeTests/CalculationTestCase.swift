//
//  CalculationTestCase.swift
//  CountOnMeTests
//
//  Created by Janin Culhaoglu on 11/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculationTestCase: XCTestCase {

    var calculation: Calculation!

    //This method is called before the invocation of each test method in the class.
    override func setUp() {
        super.setUp()
        calculation = Calculation()
    }

    //This method is called after the invocation of each test method in the class.
    override func tearDown() {
        super.tearDown()
        calculation = nil
    }

    // MARK: - Tests calculate with operators
    func testCalculateTotal_WhenAdditionOperation_shouldReturnCorrectResultInString() {
        _ = calculation.addNewNumber(1)
        _ = calculation.calculate(with: .addition)
        _ = calculation.addNewNumber(1)

        XCTAssertEqual(calculation.calculateTotal(), "2")
    }

    func testCalculateTotal_WhenSubtractionOperation_shouldReturnCorrectResultInString() {
        _ = calculation.addNewNumber(1)
        _ = calculation.calculate(with: .subtraction)
        _ = calculation.addNewNumber(1)

        XCTAssertEqual(calculation.calculateTotal(), "0")
    }

    // MARK: - Tests with Decimal Point
    func testAddDecimalPointToNumber_whenAlreadyContainsOne_shouldNotAddSecondDecimalPoint() {
        _ = calculation.addNewNumber(1)
        _ = calculation.addDecimalPoint()

        _ = calculation.addDecimalPoint()

        XCTAssertNotEqual(calculation.stringNumbers[0], "1..")
    }

    // MARK: - Tests remove numbers
    func testRemoveLastNumber_whenOnlyOneNumber_shouldReturnEmptyString() {
        _ = calculation.addNewNumber(1)

        _ = calculation.removeLastNumber()

        XCTAssertEqual(calculation.stringNumbers[0], "")
    }

    func testRemoveLastNumber_whenTwoNumbersInAddition_shoulReturnFirstNumber() {
        _ = calculation.addNewNumber(1)
        _ = calculation.calculate(with: .addition)
        _ = calculation.addNewNumber(1)

        _ = calculation.removeLastNumber()

        XCTAssertEqual(calculation.stringNumbers[0], "1")
    }

    // MARK: - Tests alert messages when Incorrect Expressions
    func testCalculateTotal_whenLastStringNumberIsAnOperator_shouldReturnEmptyStringWithAlertMessage() {
        let alertSpy = AlertDelegateSpy()
        calculation.alertDelegate = alertSpy
        _ = calculation.addNewNumber(1)
        _ = calculation.calculate(with: .addition)

        _ = calculation.calculateTotal()

        XCTAssertEqual(calculation.calculateTotal(), "")
        XCTAssertEqual(alertSpy.getMessage, "Entrez une expression correcte !")
    }

    func testCalculateTotal_whenEmptyStringNumbers_shouldReturnAlertMessage() {
        let alertSpy = AlertDelegateSpy()
        calculation.alertDelegate = alertSpy

        _ = calculation.calculateTotal()

        XCTAssertEqual(alertSpy.getMessage, "Démarrez un nouveau calcul !")
    }

    func testAddingOperator_whenLastStringNumberIsAnOperator_shouldReturnAlertMessage() {
        let alertSpy = AlertDelegateSpy()
        calculation.alertDelegate = alertSpy
        _ = calculation.addNewNumber(1)
        _ = calculation.calculate(with: .addition)

        _ = calculation.calculate(with: .addition)

        XCTAssertEqual(alertSpy.getMessage, "Expression incorrecte !")
    }

    class AlertDelegateSpy: AlertDelegate {
        var getMessage = ""

        func presentAlert(title: String, message: String) {
            getMessage = message
        }
    }
}
