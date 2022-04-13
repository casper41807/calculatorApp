//
//  calculatorViewController.swift
//  calculatorApp
//
//  Created by 陳秉軒 on 2022/4/10.
//

import UIKit

class calculatorViewController: UIViewController {

    @IBOutlet var numberOutlets: [UIButton]!
    
    @IBOutlet var operatorOutlets: [UIButton]!
//
    @IBOutlet weak var resultLabel: UILabel!
    
    var dialFirstDigit = true
    var decimals = false
    var equation = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for numberOutlet in numberOutlets{
            numberOutlet.layer.cornerRadius = numberOutlet.frame.height/2
            numberOutlet.backgroundColor = .gray
            numberOutlet.tintColor = .white
        }
        for operatorOutlet in operatorOutlets{
            operatorOutlet.layer.cornerRadius = operatorOutlet.frame.height/2
            operatorOutlet.backgroundColor = .orange
            operatorOutlet.tintColor = .white
        }
        operatorOutlets[3].backgroundColor = .gray
        view.backgroundColor = .black
        resultLabel.text = "0"
        resultLabel.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func numberButton(_ sender: UIButton) {
        let inPutNum = sender.tag
        //判斷是否輸入第一位數
        if dialFirstDigit == true{
            resultLabel.text = String(inPutNum)
            dialFirstDigit = false
        }else{
            //判斷第一位數是否為0
            if resultLabel.text != "0" {
                resultLabel.text! += String(inPutNum)
            } else {
                resultLabel.text! = String(inPutNum)
            }
        }
    }
    
    @IBAction func dotButton(_ sender: UIButton) {
        if decimals == false{
            resultLabel.text! += "."
            decimals = true
        }
    }
    
    @IBAction func clearAll(_ sender: UIButton) {
        resultLabel.text = "0"
        decimals = false
        equation = ""
    }
    
    @IBAction func calculatingSigns(_ sender: UIButton) {
        var doubleNum: String
        if decimals == false {
            doubleNum = ".0"
        } else {
            doubleNum = ""
        }
        if let inputNum = resultLabel.text{
            switch sender.tag{
            case 0:
                equation += inputNum + doubleNum + "/"
            case 1:
                equation += inputNum + doubleNum + "*"
            case 2:
                equation += inputNum + doubleNum + "-"
            case 3:
                equation += inputNum + doubleNum + "+"
                
            default:
                return
            }
        }
        print(equation)
        dialFirstDigit = true
        decimals = false
    }
    
    
    @IBAction func calculatingButton(_ sender: UIButton) {
        if let inputNum = resultLabel.text {
            equation += inputNum
            print(equation)
        }
        let expression = NSExpression(format: equation)
        if let calculateResult = expression.expressionValue(with: nil, context: nil) as? Double {
            print(calculateResult)
            if calculateResult.truncatingRemainder(dividingBy: 1) == 0 {
                resultLabel.text = String(calculateResult.floor(toInteger: 1))
                //resultLabel.text = String(Int(calculateResult))
                print(calculateResult)
            } else {
                resultLabel.text = String(calculateResult.rounding(toDecimal: 6))
                decimals = true
            }
        }
        print(decimals)
        dialFirstDigit = true
        equation = ""
        //decimals = false
    }
    
    
    @IBAction func PositiveAndNegative(_ sender: UIButton) {
        if let inPutnum = resultLabel.text{
            if inPutnum != "0" {
                if let doubleInputNum = Double(inPutnum){
                    if doubleInputNum > 0 {
                        if decimals == true{
                            resultLabel.text = "-\(doubleInputNum)"
                        }else{
                            resultLabel.text = "-\(Int(doubleInputNum))"
                        }
                    }else{
                        if decimals == true{
                            resultLabel.text = "\(fabs(doubleInputNum))"
                        }else{
                            resultLabel.text = "\(abs(Int(doubleInputNum)))"
                        }
                    }
                }
            }
        }
    }
    
    
}
    
    
       // 後退鍵
//    @IBAction func deleteNum(_ sender: UIButton) {
//        if  resultLabel.text!.count > 1{
//            resultLabel.text?.removeLast()
//        }else if resultLabel.text != "0"{
//            resultLabel.text = "0"
//        }
//        if resultLabel.text!.count < 2{
//            isDecimals = false
//        }
//    }

          //階乘
//        result = 1
//        if decimals == true {
//            showAlert()
//        } else {
//            if let factorialNum = Int(numberLabel.text!) {
//                if factorialNum != 0 {
//                    for num in 1...factorialNum {
//                        result *= num
//                    }
//                }
//            }
//            numberLabel.text = String(result)
//        }
    


