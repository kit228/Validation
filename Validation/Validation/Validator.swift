//
//  Validator.swift
//  Validation
//
//  Created by Вениамин Китченко on 06.10.2021.
//

import Foundation

//struct ValidatorError: Error {
//    var message: String
//    
//    init(_ message: String) {
//        self.message = message
//    }
//}


class Validator {
    
    func nameIsValid(_ string: String?) -> Bool {
        
//        do {
//            print("Проверяем валидность")
//            if try NSRegularExpression(pattern: "[a-zA-Z]{2,26}", options: .caseInsensitive) == nil {
//                return false
//            }
//        } catch {
//            return false
//        }
//        return true
//    }
        print("строка: ", string)
        guard let string = string else { return false }
        if string.count < 2 {
            return false
        } else {
            return true
        }
    }
    
}
