//
//  ViewController.swift
//  Validation
//
//  Created by Вениамин Китченко on 04.10.2021.
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - UI Elements
    
    private lazy var scrollVIew = UIScrollView()
    private lazy var contentView = UIView()
    
    private lazy var registrationLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(40)
        label.textAlignment = .center
        label.text = "Регистрация".uppercased()
        label.textColor = .white
        return label
    }()
    
    private lazy var lastNameTextField = AttributedTextField(placeHolderText: "Фамилия")
    private lazy var nameTextField = AttributedTextField(placeHolderText: "Имя")
    private lazy var birthDateTextField = AttributedTextField(placeHolderText: "Дата рождения дд.мм.ггг")
    private lazy var passwordTextField = AttributedTextField(placeHolderText: "Пароль")
    private lazy var passwordRepeatTextField = AttributedTextField(placeHolderText: "Повторите пароль")
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.sizeToFit()
        button.backgroundColor = .gray
        button.setTitle("Зарегистрироваться", for: .normal)
        button.addTarget(self, action: #selector(tappedRegistration), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(named: "PrettyRed")
        setupSubviews()
        addKeyboardObservers()
        addDismissKeyboardViewRecognizer()
        setupTextFiels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addKeyboardObservers()
        //lastNameTextField.becomeFirstResponder()
    }
    
    override func  viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
    // MARK: - Validate fields
    
    @objc func tappedRegistration() {
        print("Нажата кнопка регистрации")
        
        if Validator().nameIsValid(nameTextField.text) {
            print("Поле имени валидно")
        } else {
            nameTextField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    // MARK: - Keyboard
    
    // add/remove notification for keyboard (need for moving screen)
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // move screen when keyboard will show or hide
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y == 0 {
//                self.view.frame.origin.y -= keyboardSize.height
//            }
            var contentInset: UIEdgeInsets = scrollVIew.contentInset
            contentInset.bottom = keyboardSize.height
            scrollVIew.contentInset = contentInset
        }
    }
    
    @objc func keyboardWillHide() {
//        if self.view.frame.origin.y != 0 {
//            self.view.frame.origin.y = 0
//        }
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        scrollVIew.contentInset = contentInset
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
    
    // MARK: - Setup textFields
    
    private func setupTextFiels() {
        passwordTextField.isSecureTextEntry = true
        passwordRepeatTextField.isSecureTextEntry = true
        addTextFieldDelegate()
    }
    
    // delegates for textFiels
    private func addTextFieldDelegate() {
        nameTextField.delegate = self
        lastNameTextField.delegate = self
        birthDateTextField.delegate = self
        passwordTextField.delegate = self
        passwordRepeatTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // scroll to textField when editing
        
//        scrollVIew.setContentOffset(CGPoint(x: 0, y: textField.superview?.frame.origin.y ?? 0), animated: true)
        textField.layer.borderColor = UIColor.black.cgColor
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // action when at selected field pressed button return on keyboard
        
        textField.resignFirstResponder()
        if textField == nameTextField {
            lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            birthDateTextField.becomeFirstResponder()
        } else if textField == birthDateTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordRepeatTextField.becomeFirstResponder()
        } else {
            hideKeyboard()
        }
        return true
    }
    
    // MARK: - Layout
    
    private func setupSubviews() {
        view.addSubview(scrollVIew)
        scrollVIew.addSubview(contentView)
        contentView.addSubview(registrationLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(lastNameTextField)
        contentView.addSubview(birthDateTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(passwordRepeatTextField)
        contentView.addSubview(registrationButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupScrollView()
        setupContentView()
        setupConstraintsForRegistrationLabel()
        setupConstraintsForNameTextField()
        setupConstraintsForLastNameTextField()
        setupConstraintsBirthDateTextField()
        setupConstraintsPasswordTextField()
        setupConstraintsPasswordRepeatTextField()
        setupConstraintsRegistrationButton()
    }
    
    // MARK: - Constraints
    
    private func setupScrollView() {
        scrollVIew.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .leading, .trailing]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: scrollVIew, attribute: $0, relatedBy: .equal, toItem: view, attribute: $0, multiplier: 1, constant: 0)
        })
        scrollVIew.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollVIew.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .leading, .trailing]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: contentView, attribute: $0, relatedBy: .equal, toItem: scrollVIew, attribute: $0, multiplier: 1, constant: 0)
        })
        contentView.centerXAnchor.constraint(equalTo: scrollVIew.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: scrollVIew.centerYAnchor).isActive = true
    }
    
    private func setupConstraintsForRegistrationLabel() {
        registrationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([registrationLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0), registrationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: registrationLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: kLabelWidth)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: registrationLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: kLabelHeight)])
    }
    
    private func setupConstraintsForNameTextField() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([nameTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0), nameTextField.centerYAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 100)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: nameTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: kLabelWidth)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: nameTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: kLabelHeight)])
    }
    
    private func setupConstraintsForLastNameTextField() {
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([lastNameTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0), lastNameTextField.centerYAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: lastNameTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: kLabelWidth)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: lastNameTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: kLabelHeight)])
    }
    
    private func setupConstraintsBirthDateTextField() {
        birthDateTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([birthDateTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0), birthDateTextField.centerYAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 100)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: birthDateTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: kLabelWidth)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: birthDateTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: kLabelHeight)])
    }
    
    private func setupConstraintsPasswordTextField() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([passwordTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0), passwordTextField.centerYAnchor.constraint(equalTo: birthDateTextField.bottomAnchor, constant: 100)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: passwordTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: kLabelWidth)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: kLabelHeight)])
    }
    
    private func setupConstraintsPasswordRepeatTextField() {
        passwordRepeatTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([passwordRepeatTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0), passwordRepeatTextField.centerYAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: passwordRepeatTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: kLabelWidth)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: passwordRepeatTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: kLabelHeight)])
    }
    
    private func setupConstraintsRegistrationButton() {
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([registrationButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0), registrationButton.centerYAnchor.constraint(equalTo: passwordRepeatTextField.bottomAnchor, constant: 80)])
    }

}
