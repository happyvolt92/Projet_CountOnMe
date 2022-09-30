//
//  calculatorTest.swift
//  CountOnMe
//
//  Created by Elodie Gage on 16/09/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//



@testable import CountOnMe
import XCTest

class CalculatorTestCase: XCTestCase {

    var calculator: Calculator!

    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }

    // MARK: - Reset Test

    func testGivenExpressionIsNotEmpty_WhenResetting_ThenExpressionIsEmpty() {
        calculator.addNumber(3)
        _ = calculator.addOperator(operand: "-")

        calculator.resetExpression()

        XCTAssertEqual(calculator.currentExpression, "")
    }

    // MARK: - Adding Operators Test

    func testGivenExpressionHasANumber_WhenAddingWrongOperator_ThenItIsNotPossible() {
        calculator.addNumber(5)

        let operatorAdded = calculator.addOperator(operand: "y")

        XCTAssertFalse(operatorAdded)
    }

    func testGivenExpressionHasNumbersAndOperatorAndIsNotComputed_WhenAddingOperator_ThenAddingOperatorIsPossible() {
        calculator.addNumber(2)
        _ = calculator.addOperator(operand: "+")
        calculator.addNumber(8)

        let operatorAdded = calculator.addOperator(operand: "-")

        XCTAssertTrue(operatorAdded)
    }

    func testGivenExpressionLastByAnOperator_WhenAddingOperator_ThenItIsNotPossible() {
        calculator.addNumber(2)
        _ = calculator.addOperator(operand: "+")

        let operatorAdded = calculator.addOperator(operand: "/")

        XCTAssertFalse(operatorAdded)
    }


    // MARK: - Computing Tests
    
    func testGivenExpressionHasOnlyTwoElements_WhenComputing_ThenComputingIsNotPossible() {
        calculator.addNumber(3)
        _ = calculator.addOperator(operand: "+")

        let result = calculator.computeExpression()

        XCTAssertFalse(result)
    }


    func testGivenExpressionHasAlreadyAResult_WhenComputing_ThenComputingIsPossibleAndResultIsTheSame() {
        calculator.addNumber(5)
        _ = calculator.addOperator(operand: "x")
        calculator.addNumber(2)
        _ = calculator.computeExpression()

        let result = calculator.computeExpression()

        XCTAssertTrue(result)
        XCTAssertEqual(calculator.currentExpression, "5 x 2 = 10.0")
    }

    func testGivenExpressionEndsWithAnOperator_WhenComputing_ThenComputingIsNotPossible() {
        calculator.addNumber(7)
        _ = calculator.addOperator(operand: "+")
        calculator.addNumber(3)
        _ = calculator.addOperator(operand: "+")

        let result = calculator.computeExpression()

        XCTAssertFalse(result)
    }

    func testGivenExpressionIsADivision_WhenComputing_ThenResultDisplayedIsRounded() {
        calculator.addNumber(85)
        _ = calculator.addOperator(operand: "/")
        calculator.addNumber(7)

        _ = calculator.computeExpression()

        XCTAssertEqual(calculator.currentExpression, "85 / 7 = 12.14")
        XCTAssertNotEqual(calculator.currentExpression, "85 / 7 = 12.1428571")
    }

    // MARK: - Adding Numbers Tests

    func testGivenExpressionIsEmpty_WhenAddingANumber_ThenNumberIsAddedToCurrentExpression() {
        calculator.addNumber(3)

        XCTAssertEqual(calculator.currentExpression, "3")
    }

    func testGivenExpressionHasResult_WhenAddingANumber_ThenCurrentExpressionEqualsToNumberAdded() {
        calculator.addNumber(3)
        _ = calculator.addOperator(operand: "-")
        calculator.addNumber(1)
        _ = calculator.computeExpression()

        calculator.addNumber(3)

        XCTAssertEqual(calculator.currentExpression, "3")
    }

    // MARK: - Additions Tests

    func testGivenExpressionHasOneNumber_WhenAddingPlusSign_ThenAddingPlusSignIsPossibleAndExpressionIsTheNumberAndPlusSign() {
        calculator.addNumber(1)

        let result = calculator.addOperator(operand: "+")

        XCTAssertTrue(result)
        XCTAssertEqual(calculator.currentExpression, "1 + ")
    }

    func testGivenExpressionIsEmpty_WhenAddingPlusSign_ThenAddingPlusSignIsNotPossibleAndExpressionIsEmpty() {
        let operatorAdded = calculator.addOperator(operand: "+")

        XCTAssertFalse(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "")
    }

    func testGivenExpressionHasAResult_WhenAddingPlusSign_ThenAddingPlusSignIsNotPossibleAndExpressionIsTheSame() {
        calculator.addNumber(2)
        _ = calculator.addOperator(operand: "+")
        calculator.addNumber(2)
        _ = calculator.computeExpression()

        let operatorAdded = calculator.addOperator(operand: "+")

        XCTAssertFalse(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "2 + 2 = 4.0")
    }

    // MARK: - Substractions Tests
    
        func testGivenExpressionHasOneNumber_WhenAddingMinusSign_ThenAddingMinusSignIsPossibleAndExpressionIsTheNumberAndMinusSign() {
        calculator.addNumber(8)

        let operatorAdded = calculator.addOperator(operand: "-")

        XCTAssertTrue(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "8 - ")
    }

    func testGivenExpressionIsEmpty_WhenAddingMinusSign_ThenAddingMinusSignIsNotPossibleAndExpressionIsEmpty() {
        let operatorAdded = calculator.addOperator(operand: "-")

        XCTAssertFalse(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "")
    }
    
    // MARK: - Multiplications Test
    
    func testGivenExpressionHasOneNumber_WhenAddingMultiplySign_ThenAddingMultiplySignIsPossibleAndExpressionIsTheNumberAndMultiplySign() {
            calculator.addNumber(1)

            let operatorAdded = calculator.addOperator(operand: "x")

            XCTAssertTrue(operatorAdded)
            XCTAssertEqual(calculator.currentExpression, "1 x ")
        }

        func testGivenExpressionIsEmpty_WhenAddingMultiplySign_ThenAddingMultiplySignIsNotPossibleAndExpressionIsEmpty() {
            let operatorAdded = calculator.addOperator(operand: "x")

            XCTAssertFalse(operatorAdded)
            XCTAssertEqual(calculator.currentExpression, "")
        }

        func testGivenExpressionHasAResult_WhenAddingMultiplySign_ThenAddingMultiplySignIsNotPossibleAndExpressionIsTheSame() {
            calculator.addNumber(5)
            _ = calculator.addOperator(operand: "x")
            calculator.addNumber(2)
            _ = calculator.computeExpression()

            let operatorAdded = calculator.addOperator(operand: "x")

            XCTAssertFalse(operatorAdded)
            XCTAssertEqual(calculator.currentExpression, "5 x 2 = 10.0")
        }

    // MARK: - Divisions Tests
    
    func testGivenExpressionHasOneNumber_WhenAddingDivideSign_ThenAddingDivideSignIsPossibleAndExpressionIsTheNumberAndDivideSign() {
            calculator.addNumber(1)

            let operatorAdded = calculator.addOperator(operand: "/")

            XCTAssertTrue(operatorAdded)
            XCTAssertEqual(calculator.currentExpression, "1 / ")
        }

        func testGivenExpressionIsEmpty_WhenAddingDivideSign_ThenAddingDivideSignIsNotPossibleAndExpressionIsEmpty() {
            let operatorAdded = calculator.addOperator(operand: "/")

            XCTAssertFalse(operatorAdded)
            XCTAssertEqual(calculator.currentExpression, "")
        }

        func testGivenExpressionHasAResult_WhenAddingDivideSign_ThenAddingDivideSignIsNotPossibleAndExpressionIsTheSame() {
            calculator.addNumber(10)
            _ = calculator.addOperator(operand: "/")
            calculator.addNumber(2)
            _ = calculator.computeExpression()

            let operatorAdded = calculator.addOperator(operand: "/")

            XCTAssertFalse(operatorAdded)
            XCTAssertEqual(calculator.currentExpression, "10 / 2 = 5.0")
        }


    // MARK: - Divisions by 0 Tests
    
    func testGivenExpressionIsADivision_WhenDividingByZero_ThenComputingIsNotPossible() {
            calculator.addNumber(10)
            _ = calculator.addOperator(operand: "/")
            calculator.addNumber(0)

            let result = calculator.computeExpression()

            XCTAssertFalse(result)
        }
    
    // MARK: - Priorities
    
    func testGivenExpressionHasAllTypesOfOperators_WhenComputing_ThenResultIsCorrectWithOperationPriorities() {
            calculator.addNumber(10)
            _ = calculator.addOperator(operand: "/")
            calculator.addNumber(2)
            _ = calculator.addOperator(operand: "+")
            calculator.addNumber(5)
            _ = calculator.addOperator(operand: "x")
            calculator.addNumber(2)
            _ = calculator.addOperator(operand: "-")
            calculator.addNumber(5)

            _ = calculator.computeExpression()

            XCTAssertEqual(calculator.currentExpression, "10 / 2 + 5 x 2 - 5 = 10.0")
            XCTAssertNotEqual(calculator.currentExpression, "10 / 2 + 5 x 2 - 2 = 18.0")

        }

}
