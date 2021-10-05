//
//  ViewController.swift
//  Validation
//
//  Created by Вениамин Китченко on 04.10.2021.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var registrationLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(40)
        label.textAlignment = .center
        label.text = "Регистрация".uppercased()
        return label
    }()
    
    private lazy var nameTextField = AttributedTextField(placeHolderText: "Имя")
    private lazy var lastNameTextField = AttributedTextField(placeHolderText: "Фамилия")
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(named: "PrettyRed")
        setupSubviews()
        addKeyboardObservers()
        addDismissKeyboardViewRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addKeyboardObservers()
    }
    
    override func  viewWillDisappear(_ animated: Bool) {
        removeKeyboardObservers()
    }
    
    // MARK: - Keyboard
    
    // add/remove notification for keyboard (need for movuing screen)
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // move screen when keyboard will show or hode
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // add recognizer tap for view (need for hide keyboard by tapping at view)
    func addDismissKeyboardViewRecognizer() {
        let dismissKeyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        //dismissKeyboardRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(dismissKeyboardRecognizer)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Layout
    
    private func setupSubviews() {
        view.addSubview(registrationLabel)
        view.addSubview(nameTextField)
        view.addSubview(lastNameTextField)
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupConstraintsForRegistrationLabel()
        setupConstraintsForNameTextField()
        setupConstraintsForLastNameTextField()
    }
    
    // MARK: - Constraints
    
    private func setupConstraintsForRegistrationLabel() {
        registrationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([registrationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0), registrationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: registrationLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: kLabelWidth)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: registrationLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: kLabelHeight)])
    }
    
    private func setupConstraintsForNameTextField() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0), nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: nameTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: kLabelWidth)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: nameTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: kLabelHeight)])
    }
    
    private func setupConstraintsForLastNameTextField() {
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([lastNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0), lastNameTextField.centerYAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: -80)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: lastNameTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: kLabelWidth)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: lastNameTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: kLabelHeight)])
    }

}
