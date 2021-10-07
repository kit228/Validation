//
//  MainScreenViewController.swift
//  Validation
//
//  Created by Вениамин Китченко on 07.10.2021.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    private let name: String
    
    // MARK: - UI Elements
    
    private lazy var helloButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.setTitle("Приветствие", for: .normal)
        button.addTarget(self, action: #selector(greetings), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }
    
    // MARK: - Lifecycle
    
    init(name: String) {
        self.name = name
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Greetings
    
    @objc func greetings() {
        let alert = UIAlertController(title: nil, message: "Здравствуйте, \(name)!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Здарова с:", style: .default, handler: { action in
            switch action.style {
            case .default:
                alert.dismiss(animated: true, completion: nil)
            case .cancel:
            break
            case .destructive:
            break
            @unknown default:
            break
            }
        }))
        self.present(alert, animated: true, completion: nil)
        //alert.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Layout
    
    private func setupSubviews() {
        view.backgroundColor = UIColor(named: "PrettyRed")
        view.addSubview(helloButton)
        setupConstraints()
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        helloButton.translatesAutoresizingMaskIntoConstraints = false
        helloButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        helloButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        helloButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
}
