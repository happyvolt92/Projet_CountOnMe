//
//  ViewController.swift
//  P5_CountOnMe
//
//  Created by Elodie GAGE on 04/11/2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operandButtons: [UIButton]!

    // MARK: - Property

    let calculator = Calculator()

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonsAspect(in: numberButtons)
        setButtonsAspect(in: operandButtons)
        setAspect(for: textView)
        setTextViewBehavior()
    }
    // MARK: - Actions

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        calculator.addNumber(sender.tag)
    }
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        let success = calculator.addOperator(operand: "+")

        if !success {
            incorrectExpressionAlert()
        }
    }
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        let success = calculator.addOperator(operand: "-")

        if !success {
            incorrectExpressionAlert()
        }
    }

    @IBAction func tappedMultiplyButton(_ sender: UIButton) {
        let success = calculator.addOperator(operand: "x")

        if !success {
            incorrectExpressionAlert()
        }
    }

    @IBAction func tappedDivideButton(_ sender: UIButton) {
        let success = calculator.addOperator(operand: "/")

        if !success {
            incorrectExpressionAlert()
        }
    }

    @IBAction func tappedPointButton(_ sender: UIButton) {
        let success = calculator.addPoint()

        if !success {
            incorrectExpressionAlert()
        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        let success = calculator.computeExpression()

        if !success {
            incorrectExpressionAlert()
        }
    }

    @IBAction func tappedResetButton(_ sender: UIButton) {
        calculator.resetExpression()
    }

    // MARK: - Private

    @objc private func displayCalculus() {
        textView.text = calculator.currentExpression
        // automatic scroll down of the textView :
        let range = NSMakeRange(textView.text.count - 1, 0)
        textView.scrollRangeToVisible(range)
    }

    // MARK: - UI Aspect

    private func setTextViewBehavior() {
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = true
    }

    private func setButtonsAspect(in buttonsArray: [UIButton]) {
        for button in buttonsArray {
            setAspect(for: button)
        }
    }

    private func setAspect(for viewElement: UIView) {
        viewElement.layer.cornerRadius = 5
        viewElement.layer.borderWidth = 0.5
        viewElement.layer.borderColor = UIColor.darkGray.cgColor
    }

    // MARK: - Alert

    private func incorrectExpressionAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Wrong expression", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}
