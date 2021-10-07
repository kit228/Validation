//
//  StartupViewController.swift
//  Validation
//
//  Created by Вениамин Китченко on 05.10.2021.
//

import UIKit

class StartupViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var helloLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(30)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Добро пожаловать!"
        return label
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(named: "PrettyRed")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupSubviews()
        startRefistrationViewController()
    }
    
    // MARK: - Routing
    
    func startRefistrationViewController() {
        print("Запускаем registrationViewController")
        let registrationViewController = RegistrationViewController()
        registrationViewController.modalTransitionStyle = .crossDissolve
        registrationViewController.modalPresentationStyle = .fullScreen
        //self.show(registrationViewController, sender: self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.present(registrationViewController, animated: true, completion: nil)
        })
    }
    
    // MARK: - Layout
    
    private func setupSubviews() {
        view.addSubview(helloLabel)
        setupConstraints()
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0), helloLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: helloLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: kLabelWidth)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: helloLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: kLabelHeight)])
    }

}
