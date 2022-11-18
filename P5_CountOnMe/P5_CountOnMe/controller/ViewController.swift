//
//  ViewController.swift
//  P5_CountOnMe
//
//  Created by Elodie GAGE on 04/11/2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var textAreaView: UITextView!
    @IBOutlet var numbersButtons: [UIButton]!
    @IBOutlet var operandsButtons: [UIButton]!
    @IBOutlet var ACButton: [UIButton]!
    @IBOutlet var CButton: [UIButton]!

    // MARK: - Property
    let calculator = Calculator()

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonsAspect(in: numbersButtons)
        setButtonsAspect(in: operandsButtons)
        setAspect(for: textAreaView)
        setTextViewBehavior()
        // Notification :
        let name = Notification.Name("ExpressionDidChange")
        NotificationCenter.default.addObserver(self, selector: #selector(displayCalculus), name: name, object: nil)
    }
    // MARK: - Actions

    @IBAction func tappedNumbersButton(_ sender: UIButton) {
        calculator.addNumber(sender.tag)
    }
    @IBAction func tappedAddOperatorButton(_ sender: UIButton) {
       let success =  calculator.addOperator(operand: "+")
        if !success {
            incorrectExpressionAlert()
        }
    }
    @IBAction func tappedSubstractionOperatorButton(_ sender: UIButton) {
        let success = calculator.addOperator(operand: "-")
        if !success {
            incorrectExpressionAlert()
        }
    }
    @IBAction func tappedMultiplyOperatorButton(_ sender: UIButton) {
        let success = calculator.addOperator(operand: "X")
        if !success {
            incorrectExpressionAlert()
        }
    }
    @IBAction func tappedDivideOperatorButton(_ sender: UIButton) {
        let success = calculator.addOperator(operand: "/")
        if !success {
            incorrectExpressionAlert()
        }
    }
    @IBAction func tappedDotOperatorButton(_ sender: UIButton) {
        let success = calculator.addPoint()
        if !success {
            incorrectExpressionAlert()
        }
    }
    @IBAction func tappedEqualOperatorButton(_ sender: UIButton) {
        let success = calculator.computeExpression()
        if !success {
            incorrectExpressionAlert()
        }
    }
    @IBAction func tappedResetOperatoButton(_ sender: UIButton) {
       calculator.resetExpression()
    }
    @IBAction func tappedRemoveLastOperatorButton(_ sender: UIButton) {
        calculator.removeLastExpression()
    }
    // MARK: - Private

    @objc private func displayCalculus() {
        textAreaView.text = calculator.currentExpression
    }

    // MARK: - UI Aspect

    private func setTextViewBehavior() {
        textAreaView.isSelectable = false
        textAreaView.isEditable = false
        textAreaView.isScrollEnabled = true
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
