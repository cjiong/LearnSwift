//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by 陈炯 on 15/9/15.
//  Copyright (c) 2015年 Jiong. All rights reserved.
//

import Foundation

enum Operator: Int {
    case plus = 200, minus, multiply, divide
    case `default` = 0
}

class CalculatorLogic {
    //保存上一次的值
    var lastRetainValue : Double
    //最近一次选择的操作符（加、减、乘、除）
    var currentOperator : Operator
    //临时保存MainLabel的内容，当其值为true时，输入数字时MainLabel的内容清零
    var isMainLabelTextTemporary : Bool
    
    //构造器
    init() {
        print("Calculator init")
        lastRetainValue = 0.0
        isMainLabelTextTemporary = false
        currentOperator = .default
    }
    
    //折构器
    deinit {
      print("Calculator deinit")
    }
    
    //更新主标签的方法
    func updateMainLabelStringByNumberTag(_ tag : Int, withMainLabelString mainLabelString : String) -> String {
        
        var string = mainLabelString
        
        if (isMainLabelTextTemporary) {
            string = "0"
            isMainLabelTextTemporary = false
        }
        
        let optNumber = tag - 100
        //把string转换为double
        let mainLabelDouble = (string as NSString).doubleValue
        
        //判断主标签的内容转换为double类型后是否等于0，doesStringContainDecimal方法判断是否有小数点
        if mainLabelDouble == 0 && doesStringContainDecimal(string) == false {
            return String(optNumber)
        }
        
        let resultString = string + String(optNumber)
        
        return resultString
    }
    
    //判断是否含有小数点的方法
    func doesStringContainDecimal(_ string : String) -> Bool {
        for ch in string.characters {
            if ch == "." {
                return true
            }
        }
        return false
    }
    
    //计算方法
    
    func calculatorByTag(_ tag : Int, withMainLabelString mainLabelString : String) -> String {
        
        //把String转换为double
        let currentValue = (mainLabelString as NSString).doubleValue
        
        switch currentOperator {
        case .plus:
            lastRetainValue += currentValue
        case .minus:
            lastRetainValue -= currentValue
        case .multiply:
            lastRetainValue *= currentValue
        case .divide:
            if currentValue != 0 {
                lastRetainValue /= currentValue
            } else {
                currentOperator = .default
                isMainLabelTextTemporary = true
                return "Error"
            }
        default:
            lastRetainValue = currentValue
        }
     
    
        //记录当前操作符，下次操作时使用
        currentOperator = Operator(rawValue: tag)!
        
        let resultString = NSString(format: "%g", lastRetainValue)
        
        isMainLabelTextTemporary = true
        
        return resultString as String
    }
    
    //清除方法，将calculatorLogic类恢复到初始状态后，可以重新实例化calculatorLogic类来达到这个目的，但是重新实例化会耗费过多资源
    //此方法通过初始化存储属性来达到目的
    func clean() {
        lastRetainValue = 0.0
        isMainLabelTextTemporary = false
        currentOperator = .default
    }
}






















