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
        return label
    }()
    
    private lazy var lastNameTextField = AttributedTextField(placeHolderText: "Фамилия")
    private lazy var nameTextField = AttributedTextField(placeHolderText: "Имя")
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(named: "PrettyRed")
        setupSubviews()
        addKeyboardObservers()
        addDismissKeyboardViewRecognizer()
        addTextFieldDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addKeyboardObservers()
        lastNameTextField.becomeFirstResponder()
    }
    
    override func  viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
    // MARK: - Textfield Delegates
    
    // delegate to make textfield scroll when editnig
    private func addTextFieldDelegate() {
        nameTextField.delegate = self
        lastNameTextField.delegate = self
    }
    
    // scroll to textField when editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollVIew.setContentOffset(CGPoint(x: 0, y: textField.superview?.frame.origin.y ?? 0), animated: true)
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
    
    // MARK: - Layout
    
    private func setupSubviews() {
        view.addSubview(scrollVIew)
        scrollVIew.addSubview(contentView)
        contentView.addSubview(registrationLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(lastNameTextField)
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupScrollView()
        setupContentView()
        setupConstraintsForRegistrationLabel()
        setupConstraintsForNameTextField()
        setupConstraintsForLastNameTextField()
    }
    
    // MARK: - Constraints
    
    private func setupScrollView() {
//        scrollVIew.translatesAutoresizingMaskIntoConstraints = false
//        scrollVIew.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        scrollVIew.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        scrollVIew.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        scrollVIew.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollVIew.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .leading, .trailing]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: scrollVIew, attribute: $0, relatedBy: .equal, toItem: view, attribute: $0, multiplier: 1, constant: 0)
        })
        scrollVIew.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollVIew.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupContentView() {
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.centerXAnchor.constraint(equalTo: scrollVIew.centerXAnchor).isActive = true
//        contentView.widthAnchor.constraint(equalTo: scrollVIew.widthAnchor).isActive = true
//        contentView.topAnchor.constraint(equalTo: scrollVIew.topAnchor).isActive = true
//        contentView.bottomAnchor.constraint(equalTo: scrollVIew.bottomAnchor).isActive = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .leading, .trailing]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: contentView, attribute: $0, relatedBy: .equal, toItem: scrollVIew, attribute: $0, multiplier: 1, constant: 0)
        })
        //contentView.widthAnchor.constraint(equalTo: scrollVIew.widthAnchor).isActive = true
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
        NSLayoutConstraint.activate([nameTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0), nameTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -100)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: nameTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: kLabelWidth)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: nameTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: kLabelHeight)])
    }
    
    private func setupConstraintsForLastNameTextField() {
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([lastNameTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0), lastNameTextField.centerYAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: -80)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: lastNameTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: kLabelWidth)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: lastNameTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: kLabelHeight)])
    }

}
