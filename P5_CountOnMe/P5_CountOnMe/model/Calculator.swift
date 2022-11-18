//
//  Calculator.swift
//  P5_CountOnMe
//
//  Created by Elodie GAGE on 04/11/2022.
//

import Foundation

class Calculator {

    // MARK: - Properties

    private(set) var currentExpression: String = "" {
        didSet {
            sendCurrentExpressionDidChangeNotification()
        }
    }

     var elements: [String] {
        return currentExpression.split(separator: " ").map { "\($0)" }
    }

    // MARK: - Errors check properties

    private var expressionHaveResult: Bool {
        return elements.contains("=")
    }

    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    private var expressionHaveAtLeastOneNumber: Bool {
        return elements.count >= 1 && Double(elements.first ?? "") != nil
    }

    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "X" && elements.last != "/" && currentExpression.last != "."
    }

    // MARK: - Functions

    func addNumber(_ number: Int) {
        if expressionHaveResult {
            currentExpression = ""
        }
        currentExpression.append("\(number)")
    }

    func resetExpression() {
        currentExpression = ""
    }
    func removeLastExpression() {
        currentExpression.removeLast()
    }

    func addPoint() -> Bool {
        guard expressionHaveAtLeastOneNumber, expressionIsCorrect, !expressionHaveResult else {
            return false
        }
        currentExpression.append(".")
        return true
    }

    func addOperator(operand: Character) -> Bool {
        guard expressionIsCorrect, !expressionHaveResult, expressionHaveAtLeastOneNumber else {
            return false
        }
        switch operand {
        case "+":
            currentExpression.append(" + ")
            return true
        case "-":
            currentExpression.append(" - ")
            return true
        case "X":
            currentExpression.append(" X ")
            return true
        case "/":
            currentExpression.append(" / ")
            return true
        default:
            return false
        }
    }

    func computeExpression() -> Bool {
        guard !expressionHaveResult else {
            // result is already calculated
            return true
        }
        guard expressionHaveEnoughElement, expressionIsCorrect else {
            return false
        }

        // check for operations priorities, with updated elements array returned :
        guard let reducedPriority = reducePriorityOperations(elements) else {
            return false
        }

        guard let result = reduceBasicOperations(reducedPriority) else {
            return false
        }

        // rounded result to avoid displaying too many numbers :
        let resultToDisplay = (result * 100).rounded() / 100
        currentExpression.append(" = \(resultToDisplay)")

        return true
    }

    func sendCurrentExpressionDidChangeNotification() {
        let name = Notification.Name(rawValue: "ExpressionDidChange")
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)
    }

    // MARK: - Calculus functions

    // reduce operations wich contains multiplications or divisions :
    private func reducePriorityOperations(_ elements: [String]) -> [String]? {
        // local copy of operations :
        var localElements = elements

        // Iterate over operations while there is a multiplication or division :
        while localElements.contains("X") || localElements.contains("/") {
            // check at what index we have a "x" or a "/" :
            guard let index = localElements.firstIndex(where: { $0 == "X" || $0 == "/" }) else {
                return nil
            }
            guard let left = Double(localElements[index-1]) else {
                return nil
            }
            guard let right = Double(localElements[index+1]) else {
                return nil
            }

            let operand = localElements[index]

            // Division by 0 :
            if operand == "/" && right == 0 {
                return nil
            }

            let result: Double
            switch operand {
                case "X": result = left * right
                case "/": result = left / right
                default: return nil
            }

            for _ in 1...3 {
                // Remove the 3 elements at the lowest index
                localElements.remove(at: index-1)
            }
            // Insert result of reduced operation at the lowest index
            localElements.insert("\(result)", at: index-1)
        }
        return localElements
    }

    // reduce basic additions and substractions :
    private func reduceBasicOperations(_ elements: [String]) -> Double? {
        // Create local copy of operations :
        var localElements = elements

        // Iterate over operations while an operand still here :
        while localElements.count > 1 {
            guard let left = Double(localElements[0]) else {
                return nil
            }

            let operand = localElements[1]

            guard let right = Double(localElements[2]) else {
                return nil
            }

            let result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: return nil
            }

            localElements = Array(localElements.dropFirst(3))
            localElements.insert("\(result)", at: 0)
        }

        guard let firstElement = localElements.first, let result = Double(firstElement) else {
            return nil
        }

        return result
    }

}
