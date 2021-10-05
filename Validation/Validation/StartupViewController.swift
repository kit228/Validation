//
//  StartupViewController.swift
//  Validation
//
//  Created by Вениамин Китченко on 05.10.2021.
//

import UIKit

class StartupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .green
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startRefistrationViewController()
    }
    
    func startRefistrationViewController() {
        print("Запускаем registrationViewController")
        let registrationViewController = RegistrationViewController()
        registrationViewController.modalTransitionStyle = .crossDissolve
        registrationViewController.modalPresentationStyle = .fullScreen
        //self.show(registrationViewController, sender: self)
        self.present(registrationViewController, animated: true, completion: nil)
    }

}
