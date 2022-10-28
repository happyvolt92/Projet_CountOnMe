//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operandButton: [UIButton]!
    
    let calculator = Calculator()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        calculator.addNumber(sender.tag)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        let success = calculator.addOperator(operand: "+")
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        let success = calculator.addOperator(operand: "-")
    }

    @IBAction func tappedMultiplyButton(_ sender: UIButton) {
        let success = calculator.addOperator(operand: "x")
    }

    @IBAction func tappedDivideButton(_ sender: UIButton) {
        let success = calculator.addOperator(operand: "/")
    }

    @IBAction func tappedPointButton(_ sender: UIButton) {
        let success = calculator.addPoint()
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        let success = calculator.computeExpression()
    }

    @IBAction func tappedResetButton(_ sender: UIButton) {
        calculator.resetExpression()
    }
    
    // MARK: - MAKE IT WORK
    
    /// show it in the textIView,
    @objc private func displayCalculs() {
        textView.text = calculator.currentExpression
    }
    
    // MARK: - Alert

    private func incorrectExpressionAlert() {
        let alertVC = UIAlertController(title: "error", message: "Please enter valid expression", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }

    // MARK: - disabling futur probllems
    
    /// now text view is on readOnly !!!
    private func setTextViewBehavior() {
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = true
    }

}
