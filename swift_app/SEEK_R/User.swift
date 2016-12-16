//
//  User.swift
//  SEEK_R
//
//  Created by Apprentice on 12/16/16.
//  Copyright © 2016 dbcseekrgroup. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private var accumulator = 0.0
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "±" : Operation.UnaryOperation({ -$0 }),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "×" : Operation.BianryOperation({ $0 * $1}),
        "+" : Operation.BianryOperation({ $0 + $1}),
        "-" : Operation.BianryOperation({ $0 - $1}),
        "÷" : Operation.BianryOperation({ $0 / $1}),
        "=" : Operation.Equals
    ]
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BianryOperation((Double,Double) -> Double)
        case Equals
    }
    func performOperation(symbol: String){
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BianryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBianryOperationInfo(bianryFunction: function,  firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    private func executePendingBinaryOperation(){
        if pending != nil{
            accumulator = pending!.bianryFunction(pending!.firstOperand,accumulator)
            pending = nil
        }
        
    }
    
    private var pending: PendingBianryOperationInfo?
    
    private struct PendingBianryOperationInfo {
        var bianryFunction: (Double,Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}

