//
//  ViewController.swift
//  SuperDoc
//
//  Created by Nikhil Balne on 21/11/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    private let manager: EmployeeManager = EmployeeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        let employee = Employee(name: nameTextField.text, email: emailTextField.text)

        manager.createEmployee(employee: employee)
    }
    
}

