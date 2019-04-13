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
    
    func testUpdateDisplay_WhenEnteredAdditionOperation_shouldDisplayAdditionCalculInString() {
        //When
        _ = calculation.addNewNumber(1)
        _ = calculation.calculate(with: .addition)
        _ = calculation.addNewNumber(1)
        //Then
        XCTAssertEqual(calculation.updateDisplay(), "1+1")
    }
    
    func testCalculateTotal_WhenAdditionOperation_shouldReturnCorrectResultInString() {
        //When
        _ = calculation.addNewNumber(1)
        _ = calculation.calculate(with: .addition)
        _ = calculation.addNewNumber(1)
        //Then
        XCTAssertEqual(calculation.calculateTotal(), "=2")
    }
    
    func testCalculateTotal_WhenSubtractionOperation_shouldReturnCorrectResultInString() {
        //When
        _ = calculation.addNewNumber(1)
        _ = calculation.calculate(with: .subtraction)
        _ = calculation.addNewNumber(1)
        //Then
        XCTAssertEqual(calculation.calculateTotal(), "=0")
    }
    
    func testIsExpressionCorrect_whenIncorrectExpression_shouldReturnFalseWithAlertMessage() {
        //Given
        let alertSpy = AlertDelegateSpy()
        calculation.alertDelegate = alertSpy
        //When
        _ = calculation.addNewNumber(1)
        _ = calculation.calculate(with: .addition)
        _ = calculation.calculateTotal()
        //Then
        XCTAssertFalse(calculation.isExpressionCorrect)
        XCTAssertEqual(alertSpy.getMessage, "Entrez une expression correcte !")
    }
    
    func testIsExpressionCorrect_whenErrorNewCalcul_shouldReturnFalseWithAlertMessage() {
        //Given
        let alertSpy = AlertDelegateSpy()
        calculation.alertDelegate = alertSpy
        //When
        _ = calculation.calculateTotal()
        //Then
        XCTAssertFalse(calculation.isExpressionCorrect)
        XCTAssertEqual(alertSpy.getMessage, "Démarrez un nouveau calcul !")
    }
    
    func testCanAddOperator_whenIncorrectExpression_shouldReturnFalseWithAlertMessage() {
        //Given
        let alertSpy = AlertDelegateSpy()
        calculation.alertDelegate = alertSpy
        //When
        _ = calculation.addNewNumber(1)
        _ = calculation.calculate(with: .addition)
        _ = calculation.calculate(with: .addition)
        //Then
        XCTAssertFalse(calculation.canAddOperator)
        XCTAssertEqual(alertSpy.getMessage, "Expression incorrecte !")
    }
    
    class AlertDelegateSpy: AlertDelegate {
        var getMessage = ""
        
        func presentAlert(title: String, message: String) {
            getMessage = message
        }
    }
}
