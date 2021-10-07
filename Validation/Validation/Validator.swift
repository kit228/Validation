//
//  Validator.swift
//  Validation
//
//  Created by Вениамин Китченко on 06.10.2021.
//

import Foundation

class Validator {
    
    func nameIsValid(_ string: String?) -> Bool {
        print("строка: ", string)
        guard let string = string else { return false }
        if !string.trimmingCharacters(in: .whitespaces).isEmpty {
            if string.count < 2 {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
    
    func dateIsValid(_ string: String?) -> Bool {
        guard let string = string else { return false }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        guard let dateFromTextField = dateFormatter.date(from: string) else { return false }
        guard let validationDateMin = Calendar.current.date(byAdding: .year, value: -18, to: Date()) else { return false }
        guard let validationDateMax = Calendar.current.date(byAdding: .year, value: -100, to: Date()) else { return false }
        print("dateFromTextField = \(dateFromTextField), validDateMin = \(validationDateMin), validDateMax = \(validationDateMax)")
        if (dateFromTextField > validationDateMin) || (dateFromTextField < validationDateMax) {
            return false
        } else {
            return true
        }
    }
    
    func passwordIsValid(_ string: String?) -> Bool {
        guard let string = string else { return false }
        let password = string.trimmingCharacters(in: .whitespaces) // take off whitespaces
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegx)
        return passwordCheck.evaluate(with: password)
    }
}
