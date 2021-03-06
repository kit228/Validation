//
//  AttributedTextField.swift
//  Validation
//
//  Created by Вениамин Китченко on 06.10.2021.
//

import UIKit

let kLabelWidth: CGFloat = 300
let kLabelHeight: CGFloat = 40

class AttributedTextField: UITextField {
    
    var isValid = false
    
    init(placeHolderText: String?) {
        super.init(frame: .zero)
        
        backgroundColor = .white
        textAlignment = .center
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
        font = font?.withSize(25)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        attributedPlaceholder = NSAttributedString(string: placeHolderText ?? "", attributes: [.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: UIColor.gray])
        clearButtonMode = .whileEditing
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
